select distinct search.created_at::Date as date,
        hour(search.created_at::time) as time,
        minute(search.created_at::time) as time,  
        search.email,
        search.appointment_id,
        cj.team as cj_team,
        cj.store_id as cj_Store_id,
        cl2.city as cj_city,
        cl2.region as cj_region,
        assign.ASSIGNMENT_SYSTEM,
        app.date::date as app_date, -------check 
        app.location as app_id_store_id,        -------check  - done
        cl.city as app_id_city, -------check - done
        cl.region as app_id_region,-------check - done
        -- case when oo.bought_at is not null then 1 else 0 end as bought_flag,
        -- oo.make,
        -- oo.model,
        -- oo.quoted_price

from "GA_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_SEARCH_LOG"  search
left join (
    select _id,
        status as cj_status,
        week_off_day as cj_week_off_day,
        email as cj_email,
        date_of_joining::date cj_joining_date,
        store_id,
        mobile as cj_mobile,
        team
    from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_CJ_LIST
    ) cj on upper(search.email)=upper(cj.cj_email)
left join "PC_STITCH_DB"."WEBSITE_DEALERENGINE_PROD"."APPOINTMENT" app on search.appointment_id=app.pub_appt_id
left join PC_STITCH_DB.FIVETRAN1_BI.CENTRE_LIST cl on app.location=cl.centre_id
left join PC_STITCH_DB.FIVETRAN1_BI.CENTRE_LIST cl2 on  cj.store_id=cl2.centre_id

left join (SELECT SENT.*,
    BATCH.assigned_cj,
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
 ) assign on search.appointment_id=assign.app_id and upper(search.email)=upper(assign.assigned_cj)
;



select distinct email,
created_at::Date as date,
count(distinct appointment_id)as count

from  "GA_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INS_SEARCH_LOG"
group by 1,2
order by 1,2;




;
select date::date as date,pub_appt_id,location,city_id,cl.* From  "PC_STITCH_DB"."WEBSITE_DEALERENGINE_PROD"."APPOINTMENT" app
left join PC_STITCH_DB.FIVETRAN1_BI.CENTRE_LIST cl on app.location=cl.centre_id


where pub_appt_id in ('10534320754',
'12874020752',
'10420622756',
'15711329788',
'10975523785',
'23630526758',
'10272625759',
'12292322755',
'23549920785',
'31398727753');



