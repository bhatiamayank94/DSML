select timestamp_date as date,
    cj_email,
    user_id,
    cj_joining_date,
    sum(cj_impression_flag) as impresssions,
    sum(cj_view_flag) as views,
    sum(cj_like_flag) as likes,
    count(
        distinct case
            when cj_impression_flag = 1 then PARAM_FEED_TITLE
        end
    ) as impressioned_posts,
    count(
        distinct case
            when cj_view_flag = 1 then PARAM_FEED_TITLE
        end
    ) as viewed_posts,
    count(
        distinct case
            when cj_like_flag = 1 then PARAM_FEED_TITLE
        end
    ) as liked_posts,
    from (
        select distinct PARAM_CJ_EMP_ID,
            -- PARAM_MEDIA_TITLE,
            -- PREVIOUS_TIMESTAMP::Date as PREVIOUS_TIMESTAMP_date,
            -- to_time(PREVIOUS_TIMESTAMP) as PREVIOUS_TIMESTAMP_time ,
            timestamp::date as timestamp_date,
            -- to_time(timestamp) as date_time,
            hour(to_time(timestamp)) as timestamp_hour,
            minute(to_time(timestamp)) as timestamp_minute,
            second(to_time(timestamp)) as timestamp_second,
            USER_ID,
            PARAM_GA_SESSION_ID,
            PARAM_EVENT_ACTION,
            PARAM_EVENT_CATEGORY,
            e1.PARAM_FEED_TITLE,
            -- e2.PARAM_FEED_TITLE as PARAM_FEED_TITLE_2,
            e1.NAME,
            -- e1.PARAM_FEED_ID,
            -- PARAM_ENGAGED_SESSION_EVENT
            cj.cj_email,
            cj_week_off_day,
            cj_joining_date,
            store_id,
            cj.cj_mobile,
            -- cl.region,
            -- sf.RECURRING_TYPE,
            -- sf.TRIGGER_DATE_TIME::DAte as post_trigger_date,
            -- sf.EXPIRY_DATE_TIME::date as post_expiry_date,
            config.cj_impression_flag,
            config.cj_view_flag,
            config.cj_like_flag
        from "GA_DB"."INS_APP_GA4"."EVENT" e1 --     left join (select distinct param_feed_id,
            --     param_feed_title
            -- from "GA_DB"."INS_APP_GA4"."EVENT"
            -- where timestamp::date >= (getdate()::date - 120)
            --     and param_event_category = 'insp_social_channel'
            --     and name = 'post_liked'
            --     and param_feed_id is not null
            -- ) e2 on e1.PARAM_FEED_ID = e2.PARAM_FEED_ID
            left join PC_STITCH_DB.FIVETRAN1_BI.feed_24_config config on e1.name=config.name
            left join (
                select cj._id,
                    cj.status as cj_status,
                    cj.week_off_day as cj_week_off_day,
                    cj.email as cj_email,
                    cj.date_of_joining::date cj_joining_date,
                    cj.store_id,
                    cj.mobile as cj_mobile,
                    case
                        when fran.store_id is not null then 'franchise'
                        else 'non franchise'
                    end as cj_franchise_flag
                from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_CJ_LIST cj
                    left join (
                        select distinct store_id
                        from ETL.DERIVED_DATA.FRANCHISE_ANALYTICS_SUPERSET_DATA_QUERY_RESULTS
                        Where appt_id_flag in ('Y')
                            and launch_date <= '2025-12-31'
                    ) fran on cj.store_id = fran.store_id
                where upper(cj.status) in ('ACTIVE')
            ) cj on e1.PARAM_CJ_EMP_ID = cj._id -- left join PC_STITCH_DB.FIVETRAN1_BI.CENTRE_LIST cl on cj.store_id=cl.centre_id
            -- left join GA_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_SOCIAL_FEED sf on e1.PARAM_FEED_ID=sf._id
        where PARAM_EVENT_CATEGORY in ('insp_social_channel')
            and cj.cj_franchise_flag not in ('franchise')
            and date::DAte >= (getdate()::DAte - 30) -- and NAME not in ('video_played');
    )
group by 1,2,3,4