select ab.appointment_id,
    oo.created_at::Date as insp_date,
    issue_type.category,
    issue_type.issue_type,
    dr.fk_dealer_id,
    dr.is_evaluator_inspection_miss,
    -- o.order_id,
    -- cd.dealer_code,
    -- dr.DEALER_REQUEST_ID as im_raised_id,
    -- `c`oncat(ab.appointment_id, '_', cd.dealer_code) as key,
    -- date(date_trunc('week', dr.created_at)) as im_week,
    -- date(date_trunc('month', dr.created_at)) as im_month,
    date(dr.created_at) as im_date,
    -- to_timestamp(dr.updated_at + interval '330 minutes') as im_updated_at,
    -- to_timestamp(osr.gfd_at) as gfd_at,
    -- date(date_trunc('week', osr.gfd_at)) as gfd_week,
    case
        when dr.status = 0 then 'Pending'
        when dr.status = 1 then 'Received'
        when dr.status = 2 then 'Pending'
        when dr.status = 3 then 'Pending at P.E.'
        when dr.status = 4 then 'Pending at T.E.'
        when dr.status = 5 then 'Processed'
        when dr.status = 6 then 'Rejected by T.E.'
        when dr.status = 9 then 'Closed'
    end as im_status,
    -- dr.created_by as im_created_by,
    -- ru.region as car_region,
    cd.region as dealer_region,
    -- cd.city as dealer_city,
    -- cd.state as dealer_state,
    -- to_timestamp(dr.parking_evaluation_updated_at) as pe_updated_at,
    -- dr.parking_evaluation_updated_by as pe_updated_by,
    -- to_timestamp(dr.technical_evaluation_updated_at) as te_updated_at,
    -- dr.technical_evaluation_updated_by as te_updated_by,
    -- dr.technical_evaluation_rejection_reason as te_rejection,
    -- dr.amount as technical_amount,
    dr.dealer_rfc_amount,
    dr.is_offer_accepted,
    dr.is_dealer_inspection_miss,
    -- dr.bid_id,
    -- ab.bid_amount,
    -- to_timestamp(ab.bid_time + interval '330 minutes') as bid_time,
    -- to_timestamp(ab.verified_date + interval '330 minutes') as bid_verified_date,
    -- to_timestamp(ab.rejected_at + interval '330 minutes') as bid_rejected_at,
    -- ab.rejected as bid_rejected_flag,
    -- ab.rejection_reason as bid_request_reason,
    -- -- standard remarks
    -- case
    --     when lower(ab.rejection_reason) in ('city head exemption', 'city_head_exemption') then 'CHE'
    --     when lower(ab.rejection_reason) in ('dealer backed out', 'dealer_backout') then 'DB'
    --     when lower(ab.rejection_reason) in ('operation_issue', 'operation_issue_accident') then 'Doc Issue'
    --     when lower(ab.rejection_reason) in (
    --         'inspection issue',
    --         'inspection_miss',
    --         'returned'
    --     ) then 'IM'
    --     when lower(ab.rejection_reason) in ('late_stockin') then 'Late SI'
    --     when lower(ab.rejection_reason) in ('re-inspection changes') then 'RI Change'
    --     when lower(ab.rejection_reason) in ('deal lost', 'sale_not_unblocked') then 'Other'
    --     else Null
    -- end as standard_rejection,
    -- to_timestamp(iv.first_cancellation_date) as fc_date,
    -- iv.first_cancellation_flag as fc_flag,
    -- ol.first_si,
    -- osr.is_home_delivery,
    -- osr.sale_confirmed_dealer_address_city,
    -- case
    --     when (
    --         to_timestamp(dr.created_at) > iv.first_cancellation_date
    --         and year(first_cancellation_date) <> '1970'
    --         and first_cancellation_date is not null
    --     ) then 'Inventory'
    --     else 'Live'
    -- end as im_type,
    -- to_timestamp(st.sale_date) as sale_date,
    -- case
    --     when to_date(ab.verified_date + interval '330 minutes') >= '2021-12-20' then 1
    --     else 0
    -- end as delay_gfd_start,
    -- case
    --     when date(osr.gfd_at) >= '2022-02-15' then 1
    --     else 0
    -- end as new_rfc_flag_start,
    -- case
    --     when dr.status in (5, 9) then 0
    --     else 1
    -- end as pending_flag,
    -- case
    --     when dr.status in (4, 5, 9)
    --     and dr.parking_evaluation_updated_at is not null then 1
    --     else 0
    -- end as pe_closure_flag,
    -- case
    --     when dr.status in (5, 9)
    --     and dr.technical_evaluation_updated_at is not null then 1
    --     else 0
    -- end as te_closure_flag,
    -- ifnull(
    --     datediff(
    --         'second',
    --         to_timestamp(dr.created_at),
    --         to_timestamp(dr.parking_evaluation_updated_at)
    --     ) /(60 * 60 * 24),
    --     0
    -- ) as pe_ageing_in_days,
    -- ifnull(
    --     datediff(
    --         'second',
    --         to_timestamp(dr.created_at),
    --         to_timestamp(dr.technical_evaluation_updated_at)
    --     ) /(60 * 60 * 24),
    --     0
    -- ) as te_ageing_in_days,
    -- ifnull(
    --     datediff(
    --         'second',
    --         to_timestamp(dr.created_at),
    --         to_timestamp(
    --             convert_timezone('Asia/Kolkata', current_timestamp())
    --         )
    --     ) /(60 * 60 * 24),
    --     0
    -- ) as ageing_from_now,
    -- il.inspection_by
    case
        when upper(issue_type.issue_type) not like ('%ODOMETER%')
        and dr.dealer_rfc_amount >= 5000
        and im_status in ('Closed') then 1
        else 0
    end as im_approved_flag
    from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.DEALER_REQUESTS as dr
    left join PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.DEALER_REQUEST_ISSUE_TYPE issue_type on dr.dealer_request_id = issue_type.fk_dealer_request_id
    left join PC_STITCH_DB.FIVETRAN1_BI.CDD as cd on cd.dealer_id = dr.fk_dealer_id -- inner join (
    --     select order_id,
    --         lead_id
    --     from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS
    -- ) as o on to_char(o.order_id) = to_char(dr.fk_order_id)
    inner join PC_STITCH_DB.FIVETRAN_DEALERENGINE_PROD.APP_BID as ab on dr.bid_id = ab.id_app_bid
    left join PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS oo on ab.appointment_id=oo.lead_id    
        -- left join (
    --     select bid_id,
    --         is_home_delivery,
    --         sale_confirmed_dealer_address_city,
    --         gfd_at
    --     from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDER_SALE_REQUEST
    -- ) as osr on osr.bid_id = ab.id_app_bid
    -- left join (
    --     select appointment_id,
    --         first_cancellation_date,
    --         first_cancellation_flag,
    --         id_app_auction,
    --         bought_auction
    --     from PC_STITCH_DB.FIVETRAN1_BI.INVENTORY_SUMMARY
    -- ) iv on iv.appointment_id = o.lead_id
    -- and iv.id_app_auction = ifnull(iv.bought_auction, 0)
    -- left join PC_STITCH_DB.FIVETRAN1_BI.OPS_LOGISTICS ol on ol.lead_id = o.lead_id
    -- left join PC_STITCH_DB.FIVETRAN1_BI.SALES_TRANSACTIONS as st on st.appt_id = o.lead_id
    -- left join pc_stitch_db.dw.retail_universe as ru on ru.appointment_id = o.lead_id
    -- left join (
    --     select appointment_id,
    --         inspection_by
    --     from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"
    --     where INSPECTION_STATUS in ('done')
    --         and version = '0'
    -- ) as il on ab.appointment_id = il.appointment_id
where dr.request_reason = 'INSPECTION_MISS'
    and to_date(dr.created_at) >= (getdate()::date - 60) -- -- issue type not like (odometer)
    -- and dr.amount gt 5000