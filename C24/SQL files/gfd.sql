select oo.lead_id
        ,oo.store_id
        ,oo.dealer_id
        ,oo.created_at::Date as inspection_data
        ,gfd.GFD_Date
        ,case when gfd.GFD_Date is not null then 1 else 0 end as gfd_flag

from   PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS  oo
left join (select distinct fk_order_id, date(GFD_AT) GFD_Date 
            from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDER_SALE_REQUEST) gfd on oo.order_id = gfd.fk_order_id


where oo.created_at::date >= (getdate()::date - 30)
;

