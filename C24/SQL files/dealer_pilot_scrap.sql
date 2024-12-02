select original_timestamp::date date,
        original_timestamp::time as time,
        TIMESTAMPDIFF(SECOND, time, LEAD(time) OVER (ORDER BY date,time)) AS seconds_difference,
        session_id,
        EVENT_LABEL,
        EVENT_ACTION,
        TVC_AUCTION_STATUS,
        SESSION_ID,
        TVC_DEALER_ID,
        TVC_APPOINTMENT_ID,
        ID,
        TVC_AUCTION_ID,
        EVENT_CATEGORY,
        FK_DEALER_ID

 from "PC_STITCH_DB"."DEALER_APP_PRODUCTION"."CARS24_OPEN_INSPECTION_REPORT" 

 where original_timestamp::DAte >= (getdate()::date - 60)
 and tvc_appointment_id in (select distinct lead_id
        from   PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS  
        where created_at::date >= (getdate()::date - 90)
        and created_at::date <= (getdate()::date - 10)
        and bought_at is not null)

 order by date,time


 ;


--  scrap_flag


select oo.lead_id
        ,oo.store_id
        ,case when year<2010 then 1 else 0 end as scrap_car_flag
        ,oo.quoted_price
        ,oo.dealer_id
        ,case when oo.bought_at is not null then 1 else 0 end as bought_flag
        ,oo.bought_at::date as bought_date
        ,oo.created_at::Date as inspection_date
        ,gfd.GFD_Date
        ,case when gfd.GFD_Date is not null then 1 else 0 end as gfd_flag

from   PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS  oo
left join (select distinct fk_order_id, date(GFD_AT) GFD_Date 
            from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDER_SALE_REQUEST) gfd on oo.order_id = gfd.fk_order_id


where oo.created_at::date >= (getdate()::date - 90)
and oo.created_at::date <= (getdate()::date - 10)
and gfd_flag=1
