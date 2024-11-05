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
                WHERE DATE(CREATED_AT) = DATE(sysdate()) -15 -- AND ASSIGNMENT_SYSTEM = 'proximity'
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
        select distinct il.appointment_id,
            il.inspection_start_time::timestamp as ins_start,
            il.inspection_end_time::timestamp as ins_end,
            il.inspection_end_time::date as ins_date,
            store_name,
            lower(il.inspection_by) as inspection_by,
            il.category as insp_category,
            time(
                to_timestamp(HOME_INSPECTION :scheduleTime::varchar)
            ) as booked_slot,
            HOME_INSPECTION :taskId AS TASK_ID
        from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" il
        where il.inspection_start_time::date between date(
                date_trunc(month, dateadd('month', -5, DATE(sysdate())))
            )
            and date(dateadd('day', 0, sysdate()))
            AND il.inspection_status = 'done'
            AND il.version = 0
    ) T4 ON TO_CHAR(SENT.APP_ID) = TO_CHAR(T4.appointment_id) ----and to_date(SENT.app_date) = to_date(T4.ins_end)
    LEFT JOIN ----------------ASSIGNMENTS VIA LMS----------------
    (
        SELECT appointment_id,
            date(created_at) as scheduled_date,
            date(schedule_time) as schedule_date,
            time(schedule_time) as slot,
            EVALUATOR_EMAIL as lms_cj
        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG"
        WHERE assigned_by = 'LMS'
            AND DATE(CREATED_AT) >= DATE(sysdate()) -60
    ) LMS ON TO_CHAR(LMS.APPOINTMENT_ID) = TO_CHAR(SENT.APP_ID)
    AND to_date(SENT.app_date) = to_date(lms.schedule_date)
    AND to_date(SENT.app_date) = to_date(lms.scheduled_date) ---AND to_char(SENT.SST) = to_char(lms.slot)
    ----------OUT OF BOUNDARY---------
    LEFT JOIN (
        SELECT *
        FROM (
                SELECT DISTINCT A.STORE_ID,
                    A.APP_DATE,
                    A.SLOT_START,
                    A.SLOT_END,
                    A.BATCH_ID,
                    batch_assgn.value :taskId::VARCHAR AS task_id,
                    split_part(batch_assgn.value :taskId, '-', 0) as app_id,
                    batch_assgn.value :reason::VARCHAR AS reason
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
        WHERE reason = 'out_of_boundary'
    ) OOB ON SENT.TASK_ID = OOB.TASK_ID
    AND SENT.APP_DATE = OOB.APP_DATE
    AND SENT.SLOT_START = OOB.SLOT_START ------------cj denials----------
    LEFT JOIN (
        SELECT APPOINTMENT_ID,
            DATE(APPOINTMENT_DATE_TIME) AS APP_DATE,
            TIME(APPOINTMENT_DATE_TIME) AS APPT_SLOT,
            TO_TIMESTAMP(APPOINTMENT_DATE_TIME) AS APPT_DATETIME,
            ACTION_BY,
            TO_TIMESTAMP(ACTION_DATE_TIME) AS ACTION_TIME,
            DENIED_REASON -- SELECT *
        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG"
        WHERE ACTION = 'denied'
            AND DATE(CREATED_AT) >= DATE(sysdate()) -60
            AND DENIED_REASON NOT IN ('System Denied', 'Customer cancelled on website')
    ) cjdenial on sent.APP_ID = cjdenial.APPOINTMENT_ID
    AND SENT.APP_DATE = CJDENIAL.APP_DATE
    AND SENT.SST = CJDENIAL.APPT_SLOT
    AND BATCH.ASSIGNED_CJ = CJDENIAL.ACTION_BY -------------cancellations-----------
    LEFT JOIN (
        SELECT CL.APPOINTMENT_ID,
            nvl(DATE(APPOINTMENT_DATE_TIME), APPT.DATE) AS APP_DATE,
            NVL(TIME(APPOINTMENT_DATE_TIME), TIME(APPT.TIME)) AS APPT_SLOT,
            nvl(
                TO_TIMESTAMP(CONCAT(APPT.DATE, ' ', APPT.TIME)),
                TO_TIMESTAMP(APPOINTMENT_DATE_TIME)
            ) AS APPT_DATETIME,
            ACTION_BY,
            TO_TIMESTAMP(ACTION_DATE_TIME) AS ACTION_TIME,
            DENIED_REASON -- SELECT *
        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG" CL
            LEFT JOIN "PC_STITCH_DB"."WEBSITE_DEALERENGINE_PROD"."APPOINTMENT" APPT ON CL.APPOINTMENT_ID = APPT.PUB_APPT_ID
        WHERE ACTION = 'denied'
            AND DATE(CL.CREATED_AT) >= DATE(sysdate()) -60
            AND DENIED_REASON IN ('Customer cancelled on website')
    ) CANC ON sent.APP_ID = CANC.APPOINTMENT_ID
    AND SENT.APP_DATE = CANC.APP_DATE
    AND SENT.SST = CANC.APPT_SLOT -- AND (OND.ASSIGNED_CJ = CJDENIAL.ACTION_BY OR BATCH.ASSIGNED_CJ = CJDENIAL.ACTION_BY)
    ---------late denials----------
    LEFT JOIN (
        SELECT CL.APPOINTMENT_ID,
            DATE(APPOINTMENT_DATE_TIME) AS APP_DATE,
            TIME(APPOINTMENT_DATE_TIME) AS APPT_SLOT,
            TO_TIMESTAMP(APPOINTMENT_DATE_TIME) AS APPT_DATETIME,
            ACTION_BY,
            TO_TIMESTAMP(ACTION_DATE_TIME) AS ACTION_TIME,
            DENIED_REASON
        FROM "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_HI_CHECKIN_LOG" CL
        WHERE ACTION = 'denied'
            AND DATE(CL.CREATED_AT) >= '2024-01-01'
            AND DENIED_REASON IN ('System Denied')
    ) LATE ON SENT.APP_ID = LATE.APPOINTMENT_ID
    AND SENT.APP_DATE = LATE.APP_DATE
    AND SENT.SST = LATE.APPT_SLOT --------------------C3---------------------------------------------------
    LEFT JOIN (
        Select APPOINTMENT,
            DATE(CREATED_DATE) CREATED_DATE,
            COUNT(
                case
                    when C3.CALLER_TYPE IN ('ConnectCJ') then APPOINTMENT
                end
            ) ATTEMPTS,
            COUNT(
                CASE
                    WHEN C3.CALL_TYPE in ('completed', 'Answered')
                    and C3.CALLER_TYPE IN ('ConnectCJ') then appointment
                end
            ) CONNECTS,
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
            ) as duration_seconds
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
    ) c3_cj ON TO_CHAR(c3_cj.APPOINTMENT) = TO_CHAR(batch.APP_ID)
    AND date(c3_cj.CREATED_DATE) = date(batch.app_date);