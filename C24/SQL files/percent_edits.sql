select distinct appointment_id
        ,version
        ,inspection_status
        ,case when inspection_status in ('smReview') then 'cj_inspection'
                when inspection_status in ('smReviewRejected','done') then 'qc_review'
                else null end as inspection_category
        ,review_start_time::date as review_start_date
        ,to_timestamp(review_start_time)::time as review_start_time
        ,review_end_time::date as review_end_date
        ,to_timestamp(review_end_time)::time as review_end_time
          ,count(case when inspection_status='smReview' then appointment_id else null end ) over (partition by appointment_id order by review_start_date, review_start_time rows between UNBOUNDED PRECEDING and unbounded following ) as app_id_sm_review_count
          ,count(case when inspection_status='smReviewRejected' then appointment_id else null end ) over (partition by appointment_id order by review_start_date, review_start_time rows between UNBOUNDED PRECEDING and unbounded following ) as app_id_sm_review_rejected_count
         ,count(case when inspection_status='done' then appointment_id else null end ) over (partition by appointment_id order by review_start_date, review_start_time rows between UNBOUNDED PRECEDING and unbounded following ) as app_id_done_count   
         ,case when app_id_sm_review_count=1 and app_id_done_count=1 and (app_id_sm_review_rejected_count=0 or app_id_sm_review_rejected_count is null) then 'sm_review - 1, rejected - 0, done - 1'
         when  app_id_sm_review_count=1 and app_id_sm_review_rejected_count=1 and app_id_done_count=1  then 'sm_review - 1, rejected - 1, done - 1'
         when  app_id_sm_review_count=2 and app_id_sm_review_rejected_count=1 and app_id_done_count=1  then 'sm_review - 2, rejected - 1, done - 1'
         when  app_id_sm_review_count=2 and app_id_sm_review_rejected_count=2 and app_id_done_count=1  then 'sm_review - 2, rejected - 2, done - 1'
         when  app_id_sm_review_count=2 and app_id_sm_review_rejected_count=1 and app_id_done_count=2  then 'sm_review - 2, rejected - 1, done - 2'
         when  app_id_sm_review_count=2 and (app_id_sm_review_rejected_count=0 or app_id_sm_review_rejected_count is null)  and app_id_done_count=2  then 'sm_review - 2, rejected - 0, done - 2'
                 else 'others' end as app_id_category
        --  ,count(distinct version ) over (partition by appointment_id order by review_start_date, review_start_time rows between UNBOUNDED PRECEDING and unbounded following ) as no_of_inspections,



 ,case when lower(inspection_data:carDetails:errors:registrationNumber:message) like '%rejected by qc%' then 1 else null end as reg_number
  ,case when lower(inspection_data:carDetails:errors:carColour:message) like '%rejected by qc%' then 1 else null end as carColour
 ,case when lower(inspection_data:carDetails:errors:chassisNumber:message) like '%rejected by qc%' then 1 else null end as chassisNumber
  ,case when lower(inspection_data:carDetails:errors:chassisNumberEmbossing:message) like '%rejected by qc%' then 1 else null end as chassisNumberEmbossing,
  case when lower(inspection_data:carDetails:errors:commercialToPrivate:message) like '%rejected by qc%' then 1 else null end as commercialToPrivate
 ,case when lower(inspection_data:carDetails:errors:customerName:message) like '%rejected by qc%' then 1 else null end as customerName
 ,case when lower(inspection_data:carDetails:errors:fuelType:message) like '%rejected by qc%' then 1 else null end as fuelType
,case when lower(inspection_data:carDetails:errors:make:message) like '%rejected by qc%' then 1 else null end as make_rej
,case when lower(inspection_data:carDetails:errors:model:message) like '%rejected by qc%' then 1 else null end as model_rej
 ,case when lower(inspection_data:carDetails:errors:variant:message) like '%rejected by qc%' then 1 else null end as variant_rej
 ,case when lower(inspection_data:carDetails:errors:ownerNumber:message) like '%rejected by qc%' then 1 else null end as ownerNumber
 ,case when lower(inspection_data:carDetails:errors:fitnessUpto:message) like '%rejected by qc%' then 1 else null end as fitnessUpto
 ,case when lower(inspection_data:carDetails:errors:registrationCity:message) like '%rejected by qc%' then 1 else null end as registrationCity
 ,case when lower(inspection_data:carDetails:errors:registrationMonth:message) like '%rejected by qc%' then 1 else null end as registrationMonth
 ,case when lower(inspection_data:carDetails:errors:registrationState:message) like '%rejected by qc%' then 1 else null end as registrationState
 ,case when lower(inspection_data:carDetails:errors:registrationYear:message) like '%rejected by qc%' then 1 else null end as registrationYear
 ,case when lower(inspection_data:carDetails:errors:roadTaxPaid:message) like '%rejected by qc%' then 1 else null end as roadTaxPaid
 ,case when lower(inspection_data:carDetails:errors:month:message) like '%rejected by qc%' then 1 else null end as mfg_month
 ,case when lower(inspection_data:carDetails:errors:year:message) like '%rejected by qc%' then 1 else null end as mfg_year
 ,case when lower(inspection_data:carDetails:errors:insuranceType:message) like '%rejected by qc%' then 1 else null end as insuranceType
 ,case when lower(inspection_data:carDetails:errors:isUnderHypothecation:message) like '%rejected by qc%' then 1 else null end as isUnderHypothecation,
 case when lower(inspection_data:carDetails:errors:ownershipType:message) like '%rejected by qc%' then 1 else null end as ownershipType,
 case when lower(inspection_data:carDetails:errors:rcAvailability:message) like '%rejected by qc%' then 1 else null end as rcAvailability,
 case when lower(inspection_data:carDetails:errors:rtoNocIssued:message) like '%rejected by qc%' then 1 else null end as rtoNocIssued

,inspection_data:carDetails:comments:value[0]:comment as first_comment
,inspection_data:carDetails:comments:value[1]:comment as second_comment
,inspection_data:carDetails:comments:value[2]:comment as third_comment
,inspection_data:carDetails:comments:value[3]:comment as fourth_comment
,inspection_data:carDetails:comments:value[4]:comment as fifth_comment
,inspection_data:carDetails:comments:value[5]:comment as sixth_comment
,inspection_data:carDetails:comments:value[6]:comment as seventh_comment
,inspection_data:carDetails:comments:value[7]:comment as eigth_comment
,inspection_data:carDetails:comments:value[8]:comment as fninth_comment




from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where date(inspection_start_time) >= (getdate()::Date -210);
