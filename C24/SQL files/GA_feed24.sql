select PARAM_CJ_EMP_ID,
    PARAM_MEDIA_TITLE,
    PREVIOUS_TIMESTAMP::Date as PREVIOUS_TIMESTAMP_date,
    -- to_time(PREVIOUS_TIMESTAMP) as PREVIOUS_TIMESTAMP_time ,
    timestamp::date as timestamp_date,
    to_time(timestamp) as date_time,
    hour(date_time) as timestamp_hour,
    minute(date_time) as timestamp_minute,
    second(date_time) as timestamp_second,
    USER_ID,
    PARAM_GA_SESSION_ID,
    PARAM_EVENT_ACTION,
    PARAM_EVENT_CATEGORY,
    e1.PARAM_FEED_TITLE,
    e2.PARAM_FEED_TITLE as PARAM_FEED_TITLE_2,
    NAME,
    e1.PARAM_FEED_ID,
    PARAM_ENGAGED_SESSION_EVENT
from "GA_DB"."INS_APP_GA4"."EVENT" e1
    left join (
        select distinct PARAM_FEED_TITLE,
            PARAM_FEED_ID
        from "GA_DB"."INS_APP_GA4"."EVENT"
        where date::DAte >= (getdate()::Date - 180)
    ) e2 on e1.PARAM_FEED_ID = e2.PARAM_FEED_ID
where PARAM_EVENT_CATEGORY in ('insp_social_channel')
    and date::DAte >= (getdate()::DAte - 1) -- and NAME not in ('video_played')
order by PARAM_CJ_EMP_ID,
    PARAM_GA_SESSION_ID,
    timestamp_date,
    timestamp_hour,
    timestamp_minute,
    timestamp_second,
    e1.PARAM_FEED_TITLE,
    e2.PARAM_FEED_TITLE,
    NAME;


    select distinct PARAM_EVENT_CATEGORY  from "GA_DB"."INS_APP_GA4"."EVENT"



;

select * from PC_STITCH_DB.LMS_PROD_LMS.LMS_USER_HIERARCHY limit 10 ;





select distinct param_feed_id
        ,param_feed_title
        ,count(distinct date::date) as dt_count

from  "GA_DB"."INS_APP_GA4"."EVENT" 

where PARAM_EVENT_ACTION in ('my_feed')
and date::date >= (getdate()::Date - 30)
and upper(name) not in ('VIDEO PLAYED')

group by 1,2;




