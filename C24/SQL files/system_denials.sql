SELECT SENT.*,
    BATCH.assigned_cj,
    t4.*,
    lms.*,
    oob.*,
    cjdenial.*,
    CANC.*,
    LATE.*,
    c3_cj.*
FROM -------------SENT FOR ALLOCATION------------
    (
        SELECT DISTINCT A.STORE_ID,
            A.APP_DATE,
            A.SLOT_START,
            A.SST,
            A.SLOT_END,
            -- A.BATCH_ID,
            APPT.VALUE :taskId::VARCHAR AS TASK_ID,
            SPLIT_PART(APPT.VALUE :taskId::VARCHAR, '-', 0) AS APP_ID,
            ASSIGNMENT_SYSTEM,
            mode
        FROM (
                SELECT store_id,
                    date(slot_start) as app_date,
                    slot_start,
                    TIME(SLOT_START) AS SST,
                    slot_end,
                    batch_id,
                    batch_request_data,
                    -- PARSE_JSON(BATCH_REQUEST_DATA):cjs AS SENT_CJS,
                    PARSE_JSON(BATCH_REQUEST_DATA) :tasks AS TASKS,
                    ASSIGNMENT_SYSTEM,
                    mode
                FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_LOCUS_PLAN_DATA"
                WHERE DATE(CREATED_AT) >= DATE(sysdate()) -30 -- AND ASSIGNMENT_SYSTEM = 'proximity'
                    -- AND mode = 'batch'
            ) AS A,
            LATERAL FLATTEN(INPUT => PARSE_JSON(TASKS)) AS APPT
    ) SENT
    LEFT JOIN -------------------BATCH AND OD ASSIGNMENT DATA---------------
    (
        SELECT DISTINCT A.STORE_ID,
            A.APP_DATE,
            A.SLOT_START,
            A.SLOT_END,
            A.BATCH_ID,
            batch_assgn.value :taskId::VARCHAR AS task_id,
            split_part(batch_assgn.value :taskId, '-', 0) as app_id,
            batch_assgn.value :cjLat::varchar as cj_lat,
            batch_assgn.value :cjLng::varchar as cj_lng,
            batch_assgn.value :cjName::varchar as assigned_cj,
            round(batch_assgn.value :travelDistance::varchar, 2) as dist
        FROM (
                SELECT store_id,
                    date(slot_start) AS app_date,
                    slot_start,
                    slot_end,
                    batch_id,
                    PARSE_JSON(RESPONSE_DATA) :allocation AS allocations
                FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_LOCUS_PLAN_DATA"
                WHERE DATE(CREATED_AT) >= DATE(sysdate()) -60 -- '2023-09-12'
                    -- AND ASSIGNMENT_SYSTEM = 'proximity'
                    AND mode IN ('batch', 'ondemand')
            ) AS A,
            LATERAL FLATTEN(INPUT => PARSE_JSON(allocations)) AS batch_assgn
    ) BATCH ON SENT.TASK_ID = BATCH.TASK_ID
    AND SENT.APP_DATE = BATCH.APP_DATE
    AND TO_CHAR(SENT.SLOT_START) = TO_CHAR(BATCH.SLOT_START)
    AND SENT.STORE_ID = BATCH.STORE_ID -- LEFT JOIN "PC_STITCH_DB"."FIVETRAN1_BI"."CENTRE_LIST" CL ON SENT.STORE_ID = CL.centre_id
    LEFT JOIN --------------CAD INSPECTIONS BELOW.
    (
        select distinct il.appointment_id as appointment_id_ins_log,
            il.inspection_start_time::timestamp as ins_start,
            il.inspection_end_time::timestamp as ins_end,
            il.inspection_end_time::date as ins_date,
            store_name,
            lower(il.inspection_by) as inspection_by,
            il.category as insp_category,
            time(
                to_timestamp(HOME_INSPECTION :scheduleTime::varchar)
            ) as booked_slot,
            -- HOME_INSPECTION :taskId AS TASK_ID
        from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" il
        where il.inspection_start_time::date between date(
                date_trunc(month, dateadd('month', -5, DATE(sysdate())))
            )
            and date(dateadd('day', 0, sysdate()))
            AND il.inspection_status = 'done'
            AND il.version = 0
    ) T4 ON TO_CHAR(SENT.APP_ID) = TO_CHAR(T4.appointment_id_ins_log) ----and to_date(SENT.app_date) = to_date(T4.ins_end)
    LEFT JOIN ----------------ASSIGNMENTS VIA LMS----------------
    (
        SELECT appointment_id as appointment_id_lms,
            date(created_at) as scheduled_date_lms,
            date(schedule_time) as schedule_date_lms,
            time(schedule_time) as slot_lms,
            EVALUATOR_EMAIL as cj_lms
        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG"
        WHERE assigned_by = 'LMS'
            AND DATE(CREATED_AT) >= DATE(sysdate()) -60
    ) LMS ON TO_CHAR(LMS.appointment_id_lms) = TO_CHAR(SENT.APP_ID)
    AND to_date(SENT.app_date) = to_date(lms.scheduled_date_lms)
    AND to_date(SENT.app_date) = to_date(lms.scheduled_date_lms) ---AND to_char(SENT.SST) = to_char(lms.slot)
    ----------OUT OF BOUNDARY---------
    LEFT JOIN (
        SELECT *
        FROM (
                SELECT DISTINCT A.STORE_ID as store_id_oob,
                    A.APP_DATE as app_date_oob,
                    A.SLOT_START as slot_start_oob,
                    A.SLOT_END as slot_end_oob,
                    A.BATCH_ID as batch_id_oob,
                    batch_assgn.value :taskId::VARCHAR AS task_id_oob,
                    split_part(batch_assgn.value :taskId, '-', 0) as app_id_oob,
                    batch_assgn.value :reason::VARCHAR AS reason_oob
                FROM (
                        SELECT store_id,
                            date(slot_start) as app_date,
                            slot_start,
                            slot_end,
                            batch_id,
                            PARSE_JSON(RESPONSE_DATA) :unassignedTasks AS unassigned -- select *
                        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_LOCUS_PLAN_DATA"
                        WHERE DATE(CREATED_AT) >= DATE(sysdate()) -60
                            AND ASSIGNMENT_SYSTEM = 'proximity'
                            and mode = 'batch' -- and store_id = 1209
                            -- and batch_id = '1137-20231101-0900-1000'
                    ) as A,
                    LATERAL FLATTEN(INPUT => PARSE_JSON(unassigned)) AS batch_assgn
            )
        WHERE reason_oob = 'out_of_boundary'
    ) OOB ON SENT.TASK_ID = OOB.task_id_oob
    AND SENT.APP_DATE = OOB.app_date_oob
    AND SENT.SLOT_START = OOB.slot_start_oob ------------cj denials----------
    LEFT JOIN (
        SELECT APPOINTMENT_ID as app_id_denial,
            DATE(APPOINTMENT_DATE_TIME) AS APP_DATE_denial,
            TIME(APPOINTMENT_DATE_TIME) AS APPT_SLOT_denial,
            TO_TIMESTAMP(APPOINTMENT_DATE_TIME) AS APPT_DATETIME_denial,
            ACTION_BY as action_by_denial,
            TO_TIMESTAMP(ACTION_DATE_TIME) AS ACTION_TIME_denial,
            DENIED_REASON as DENIED_REASON_denial -- SELECT *
        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG"
        WHERE ACTION = 'denied'
            AND DATE(CREATED_AT) >= DATE(sysdate()) -60
            AND DENIED_REASON NOT IN ('System Denied', 'Customer cancelled on website')
    ) cjdenial on sent.APP_ID = cjdenial.app_id_denial
    AND SENT.APP_DATE = CJDENIAL.APP_DATE_denial
    AND SENT.SST = CJDENIAL.APPT_SLOT_denial
    AND BATCH.ASSIGNED_CJ = CJDENIAL.action_by_denial -------------cancellations-----------
    LEFT JOIN (
        SELECT CL.APPOINTMENT_ID as app_id_cancel,
            nvl(DATE(APPOINTMENT_DATE_TIME), APPT.DATE) AS APP_DATE_cancel,
            NVL(TIME(APPOINTMENT_DATE_TIME), TIME(APPT.TIME)) AS APPT_SLOT_cancel,
            nvl(
                TO_TIMESTAMP(CONCAT(APPT.DATE, ' ', APPT.TIME)),
                TO_TIMESTAMP(APPOINTMENT_DATE_TIME)
            ) AS APPT_DATETIME_cancel,
            ACTION_BY as action_by_cancel,
            TO_TIMESTAMP(ACTION_DATE_TIME) AS ACTION_TIME_cancel,
            DENIED_REASON as denied_reason_cancel -- SELECT *
        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG" CL
            LEFT JOIN "PC_STITCH_DB"."WEBSITE_DEALERENGINE_PROD"."APPOINTMENT" APPT ON CL.APPOINTMENT_ID = APPT.PUB_APPT_ID
        WHERE ACTION = 'denied'
            AND DATE(CL.CREATED_AT) >= DATE(sysdate()) -60
            AND DENIED_REASON IN ('Customer cancelled on website')
    ) CANC ON sent.APP_ID = CANC.app_id_cancel
    AND SENT.APP_DATE = CANC.APP_DATE_cancel
    AND SENT.SST = CANC.APPT_SLOT_cancel -- AND (OND.ASSIGNED_CJ = CJDENIAL.ACTION_BY OR BATCH.ASSIGNED_CJ = CJDENIAL.ACTION_BY)
    ---------late denials----------
    LEFT JOIN (
        SELECT CL.APPOINTMENT_ID as appointment_id_late,
            DATE(APPOINTMENT_DATE_TIME) AS APP_DATE_late,
            TIME(APPOINTMENT_DATE_TIME) AS APPT_SLOT_late,
            TO_TIMESTAMP(APPOINTMENT_DATE_TIME) AS APPT_DATETIME_late,
            ACTION_BY as ACTION_BY_late,
            TO_TIMESTAMP(ACTION_DATE_TIME) AS ACTION_TIME_late,
            DENIED_REASON as denied_reason_late
        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG" CL
        WHERE ACTION = 'denied'
            AND DATE(CL.CREATED_AT) >= '2024-01-01'
            AND DENIED_REASON IN ('System Denied')
    ) LATE ON SENT.APP_ID = LATE.appointment_id_late
    AND SENT.APP_DATE = LATE.APP_DATE_late
    AND SENT.SST = LATE.APPT_SLOT_late --------------------C3---------------------------------------------------
    LEFT JOIN (
        Select APPOINTMENT as appointment_id_c3,
            DATE(CREATED_DATE) CREATED_DATE_c3,
            COUNT(
                case
                    when C3.CALLER_TYPE IN ('ConnectCJ') then APPOINTMENT
                end
            ) ATTEMPTS_c3,
            COUNT(
                CASE
                    WHEN C3.CALL_TYPE in ('completed', 'Answered')
                    and C3.CALLER_TYPE IN ('ConnectCJ') then appointment
                end
            ) CONNECTS_c3,
            SUM(
                round(
                    replace(
                        CASE
                            WHEN regexp_instr ((C3.legs), '"OnCallDuration":') = 0 THEN null
                            ELSE replace(
                                split_part(
                                    SPLIT_PART((C3.legs), '"OnCallDuration":', -1),
                                    ',',
                                    1
                                ),
                                '"',
                                ''
                            )
                        END,
                        '}]',
                        ''
                    ),
                    2
                )
            ) as duration_seconds_c3
        from (
                SELECT distinct APPOINTMENT,
                    CALLER_TYPE,
                    CALL_TYPE,
                    CREATED_DATE::timestamp as CREATED_DATE,
                    legs
                FROM PC_STITCH_DB.LMS_PROD_LMS.LMS_EXOTEL_LOGS
                WHERE DATE(created_date) >= Current_date -60
                    AND CALLER_TYPE IN ('ConnectCJ') ----AND APPOINTMENT IN ('11986934744')
            ) c3
        group by 1,
            2
    ) c3_cj ON TO_CHAR(c3_cj.appointment_id_c3) = TO_CHAR(batch.APP_ID)
    AND date(c3_cj.CREATED_DATE_c3) = date(batch.app_date);



    ;



    select *  

    FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG" 

    where appointment_id in ('1001553536',
'1003098026',
'1005518276',
'1033273827',
'1343586949',
'1483721241',
'1562837230',
'1802260127')

