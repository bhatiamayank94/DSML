select count(distinct param_cj_emp_id)
        ,date::Date as date
        ,count(distinct param_appointment_id)
        ,count(distinct param_feed_id)


from "GA_DB"."INS_APP_GA4"."EVENT"


where date::Date >=(getdate()::Date - 7)
group by 2;



select PARAM_APPOINTMENT_ID,

     param_cj_emp_id,
     param_event_action,
     date::Date as date,
     date

    from "GA_DB"."INS_APP_GA4"."EVENT"


where date::Date >=(getdate()::Date - 1)
and param_event_action in ('car_health_report','my_feed','my_performance_home')
;


select distinct param_event_action from "GA_DB"."INS_APP_GA4"."EVENT" where date::Date >=(getdate()::Date - 7);


select *  from 
PC_STITCH_DB.ZENDESK_IN.TICKET 

where created_at::Date >= (getdate()::DAte - 6)
and created_at::Date <= (getdate()::DAte - 1);




Select appointment_id,
inspection_data:carDetails:rcAvailability:subParts:mismatchInRC:value::string as mismatchInRC
from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG";


   select ins.appointment_id,
        inspection_end_time::date as inspection_date,
        store_id_seller,
-- Fender
        -- LHS
                case when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0')
                            then inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as fender_lhs_cc_severity_scale_scratched
from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" ins
where inspection_end_time::date >= (getdate()::date - 30)
        and store_id_seller in (1985)
        and inspection_status in ('done')
        and version=0
        and fender_lhs_cc_severity_scale_scratched  is not null
        limit 10;




        select * from 
"PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

        where appointment_id in ('10159921795');




        select onboarding_date::Date as onboarding_date,
                status,
                ob,
                count(distinct dealer_code) as dealer_count
                         from PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING 
                         where onboarding_date::date >= (getdate()::date - 15)
                         group by 1,2,3;


        select fun.* ,
        ob.*
        from PC_STITCH_DB.PRODUCT.DEALER_AUCTION_CLICKSTREAM_FUNNEL fun
        left join PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING ob on fun.tvc_dealer_id=ob.dealer_code
        where ob.onboarding_date::date >= (getdate()::Date - 5);



        select dealer_code,
                onboarding_date::Date as onboarding_date,
                region,
                status
                 from PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING 
                         where onboarding_date::date >= (getdate()::date - 5)


                         ;


                         select a.appointment_id
                                ,b.onboarding_date
                                ,b.dealer_code
                                ,a.dealer_code

                        from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"  a
                        left join PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING  b on a.dealer_code=b.dealer_code                         
;



select appointment_id,
        dealer_code from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"
where inspection_end_time::Date >=(getdate()::date - 2) limit 10;




select  ob.onboarding_date::Date as onboarding_date,
        ob.dealer_code,
        sum(impression) as impressions,
        sum(view) as views,
        sum(bid) as bids,
        sum(win) as wins


from PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING ob
left join  PC_STITCH_DB.PRODUCT.DEALER_AUCTION_CLICKSTREAM_FUNNEL fun on ob.dealer_code=fun.tvc_dealer_id

where ob.onboarding_date::Date >= (getdate()::date - 3)

group by 1,2;


select distinct fk_order_id, date(GFD_AT) GFD_Date from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDER_SALE_REQUEST;



select oo.lead_id,
oo.created_at::date as insp_date,
GFD_Date

        from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS oo
        left join (select distinct fk_order_id, date(GFD_AT) GFD_Date from 
        PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDER_SALE_REQUEST
        ) gfd on oo.order_id = gfd.fk_order_id

where oo.created_at::date >= (getdate()::Date - 90);




select count(distinct appointment_id),
        -- sum(inspection_end_time::time-inspection_start_time::time) as tat,
        inspection_by,
        inspection_end_time::date as inspection_date,
        version,
        inspection_status,
        city,
        case when store_name like ('%B2B%') or upper(store_name) like ('%PNS%') then 'b2b' else 'retail' end as store_type
-- assignement_channel
from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where inspection_end_time::Date >=(getdate()::Date - 10)
group by 2,3,4,5,6,7;



select * 

from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_CJ_LIST
where upper(name) in ('VIJAY','LEO','SURESH','DHANRAJ')
-- or upper(last_name) in ('VIJAY','LEO')
or upper(email) in ('VIJAY.R1@CARS24.COM','LEO.N1@CARS24.COM','MUKESH.GAUR@CARS24.COM')
;


select dealer_id from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS limit 10 ;

;

select  created_at::Date as inspection_date ,
* 
from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_CJ_FEEDBACK 
where updated_at::date >= (getdate()::date - 5)
and updated_at::date <= (getdate()::date - 1)
;


select ins.appointment_id,
    inspection_by,
    DATEDIFF(second,inspection_start_time,inspection_end_time) as tat,
    inspection_end_time::date as inspection_date,
    ins.version,
    ins.inspection_status,
    fb.appointment_id as appointment_id_2,
    fb.FEEDBACK_RATING,
    fb.FEEDBACKS,
    fb.email,
    fb.additional_comment,
    fb.reported_issues,
    gfd.GFD_Date,
    case when gfd.GFD_Date is not null then 1 else 0 end as gfd_flag 
from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" ins
    left join PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_CJ_FEEDBACK fb on ins.appointment_id = fb.appointment_id
    left join PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS oo on ins.appointment_id = oo.lead_id
    left join (
    select distinct fk_order_id,
        date(GFD_AT) GFD_Date
    from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDER_SALE_REQUEST
    ) gfd on oo.order_id = gfd.fk_order_id
where ins.inspection_end_time::Date >= (getdate()::date - 30)
    and ins.version = 0
    and ins.inspection_status in ('done');




select *
from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" ins
where inspection_data:exteriorTyres:bumpers:subParts:front:additionalInfo[2] is not null
and inspection_end_time::date >=(getdate()::date -10)
limit 5;


select  appointment_id,
case when  upper(inspection_data:exteriorTyres:bumpers:subParts:front) like ('%SCRATCH%') then 1 else 0 end as scratch_flag__front,
case when  upper(inspection_data:exteriorTyres:bumpers:subParts:front) like ('%DENT%') then 1 else 0 end as dent_flag_front,
case when  upper(inspection_data:exteriorTyres:bumpers:subParts:front) like ('%DAMAGE%') then 1 else 0 end as damage_flag_front,
case when  upper(inspection_data:exteriorTyres:bumpers:subParts:front) like ('%RUST%') then 1 else 0 end as rust_flag_front,

case when  upper(inspection_data:exteriorTyres:bumpers:subParts:rear) like ('%SCRATCH%') then 1 else 0 end as scratch_flag_rear,
case when  upper(inspection_data:exteriorTyres:bumpers:subParts:rear) like ('%DENT%') then 1 else 0 end as dent_flag_rear,
case when  upper(inspection_data:exteriorTyres:bumpers:subParts:rear) like ('%DAMAGE%') then 1 else 0 end as damage_flag_rear,
case when  upper(inspection_data:exteriorTyres:bumpers:subParts:rear) like ('%RUST%') then 1 else 0 end as rust_flag_rear,

from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" ins 
where inspection_end_time::date >=(getdate()::date -5);


select * from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where appointment_id in ('10037525773')


;


select count(distinct appointment_id),
        -- sum(inspection_end_time::time-inspection_start_time::time) as tat,
        inspection_by,
        inspection_end_time::date as inspection_date,
        version,
        inspection_status,
        city,
        case when store_name like ('%B2B%') or upper(store_name) like ('%PNS%') then 'b2b' else 'retail' end as store_type
-- assignement_channel
from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where inspection_end_time::Date >=(getdate()::Date - 10)
group by 2,3,4,5,6,7;





select  ob.onboarding_date::Date as onboarding_date,
        ob.dealer_code::varchar as dealer_code,
        cdd.dealer_id::varchar as dealer_id,
        fun.data_date::date as date,
        sum(impression) as impressions,
        sum(view) as views,
        sum(bid) as bids,
        sum(win) as wins


from PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING ob
left join  PC_STITCH_DB.PRODUCT.DEALER_AUCTION_CLICKSTREAM_FUNNEL fun on ob.dealer_code=fun.tvc_dealer_id
left join PC_STITCH_DB.FIVETRAN1_BI.CDD cdd on to_char(ob.dealer_code)=to_char(cdd.dealer_code)

where ob.onboarding_date::Date >= (getdate()::date - 10)

group by 1,2,3,4;



select fun.tvc_dealer_id,
        cdd.dealer_code,
        data_date::Date as click_funnel_date,
        sum(impression) as impressions,
        sum(view) as views,
        sum(bid) as bids,
        sum(win) as wins

from PC_STITCH_DB.PRODUCT.DEALER_AUCTION_CLICKSTREAM_FUNNEL fun
left join PC_STITCH_DB.FIVETRAN1_BI.CDD cdd on  fun.tvc_dealer_id=cdd.dealer_id
where data_date::DAte >= (getdate()::Date - 30)

group by 1,2,3

;

select * 
from  PC_STITCH_DB.PRODUCT.DEALER_AUCTION_CLICKSTREAM_FUNNEL 
where data_date::Date >= (getdate()::Date - 10)


;



-- coverage of pilots

-- Diff in impressions, views, bids, won, bought
-- gfd
-- bought
-- grievance data 
-- IM raised
-- IM approved

-- new format for new pilots

-- new pilots

-- new dealers


;

select distinct E1.PARAM_EVENT_ACTION,
            E1.PARAM_EVENT_CATEGORY,
            param_feed_title,
            e1.name,
            e1.param_feed_id,
        --     e1.param_ga_session_id,
            e1.PARAM_ENGAGED_SESSION_EVENT,

from "GA_DB"."INS_APP_GA4"."EVENT" e1
where date::date >= (getdate()::Date - 5);





select * from 

"GA_DB"."INS_APP_GA4"."EVENT"
where PARAM_EVENT_ACTION in ('my_feed')
and date::DAte >= (getdate()::DAte - 7);



select fun.tvc_dealer_id,
        cdd.dealer_code,
        data_date::Date as click_funnel_date,
        sum(impression) as impressions,
        sum(view) as views,
        sum(bid) as bids,
        sum(win) as wins

from PC_STITCH_DB.PRODUCT.DEALER_AUCTION_CLICKSTREAM_FUNNEL fun
left join PC_STITCH_DB.FIVETRAN1_BI.CDD cdd on  fun.tvc_dealer_id=cdd.dealer_id
where data_date::DAte >= (getdate()::Date - 30)

;


select OB.DEALER_CODE,
        OB.ONBOARDING_DATE::date as ONBOARDING_DATE,
        OB.REGION,
        DEALER_ID,
        DEALERSHIP_NAME,


from PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING OB
left join PC_STITCH_DB.FIVETRAN1_BI.CDD cdd on  TO_CHAR(OB.DEALER_CODE)=TO_CHAR(cdd.DEALER_CODE)
where onboarding_date::Date >= (getdate()::Date - 30)
and ob.dealer_code not in 
