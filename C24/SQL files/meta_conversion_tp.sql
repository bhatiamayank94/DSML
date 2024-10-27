select oo.lead_id,
        oo.created_at::date as insp_date,
        ins.store_id_seller,
        oo.make,
        oo.model,
        oo.year,
        oo.fuel_type,
        oo.bought_at::date as bought_date,
        case when oo.bought_at is null then 0 else 1 end as bought_flag,
        dstp.dstp,
        ab.*,
        cs.*
        

from  PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS oo
left join (select distinct appointment_id,
                        id_app_auction
        from PC_STITCH_DB.FIVETRAN1_BI.INVENTORY_SUMMARY 
        where auction_start_time::Date>= '2024-08-01'
        )ism on oo.lead_id=ism.appointment_id
left join (select tvc_auction_id,
        sum(impression) as impressions,
        sum(view) as views,
        sum(bid) as bids,
        sum(win) as wins,

from PC_STITCH_DB.PRODUCT.DEALER_AUCTION_CLICKSTREAM_FUNNEL 
where data_date::Date >= '2024-08-01'
group by 1
) cs on ism.id_app_auction=cs.tvc_auction_id
left join 
        (select appointment_id,
                count(distinct id_app_bid)as bids,
                count(distinct fk_dealer_id)as dealers,
                max(bid_amount) as max_bid,
                max(case when is_winner=1 then bid_amount else null end) as max_won_bid              
        from PC_STITCH_DB.FIVETRAN_DEALERENGINE_PROD.APP_BID 
        where rejected=0 
        and updated_date::date >= '2024-07-15'
        group by 1)ab on oo.lead_id=ab.appointment_id
left join   (select appointment_id
                        ,parse_json(RESPONSE_DATA):Price DSTP
                from PC_STITCH_DB.FIVETRAN_DEALERENGINE_PROD.VIS_DS_TP_V4 v4tp
                where to_date(v4tp.created_on)>='2020-11-18' and is_latest=1)dstp on oo.lead_id=dstp.appointment_id
left join (
    select distinct appointment_id,
        store_id_seller
    from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"
    where inspection_end_time::date >= '2024-08-01'
) ins on oo.lead_id = ins.appointment_id
where ins.store_id_seller in (1985)
and oo.created_at::Date >= '2024-08-01'

;

;

select tvc_auction_id,
        sum(impression) as impressions,
        sum(view) as views,
        sum(bid) as bids,
        sum(win) as wins,

from PC_STITCH_DB.PRODUCT.DEALER_AUCTION_CLICKSTREAM_FUNNEL 
where data_date::Date >= '2024-08-01'
group by 1


 ;





 select * from PC_STITCH_DB.FIVETRAN1_BI.INVENTORY_SUMMARY oo limit 10 



