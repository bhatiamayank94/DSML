select date,
-- EMAIL,
 param_event_category, param_event_action,name, param_event_label,
    param_cj_emp_id, param_appointment_id
    from "GA_DB"."INS_APP_GA4"."EVENT"  E2
--     LEFT JOIN (
--         select * from (select
--             _ID as m_id,
--             EMAIL
--         from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_CJ_LIST
--     )) CJ ON CJ.m_id = E2.param_cj_emp_id
-- where
-- param_event_action = 'car_health_report'
-- and
-- name in (
-- 'chr_customer_share_qr_code',
-- 'chr_customer_share_product_link')
-- and 
where date >= '2024-10-06'
and param_event_action = 'car_health_report'