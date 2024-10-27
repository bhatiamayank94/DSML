-- im approve
                select dealer_request_id, lead_id, bid_id, im_created_at, im_updated_at, dealer_complaint,
                case when IM_Approve=1 or dealer_rfc_amount>0 then 1 else 0 end as im_approved,
                is_offer_accepted, dealer_rfc_amount, amount
                from (
                       select a.*,
                       row_number () over(partition by bid_id order by im_created_at desc) as rank
                       from (
                             select  dealer_request_id, lead_id, bid_id, im_created_at::timestamp as im_created_at,
                             im_updated_at, IM_Approve, dealer_rfc_amount, is_offer_accepted, rfc, 
                             status,TECHNICAL_EVALUATION_UPDATED_AT, dealer_complaint, amount
                             from (
                                    select lead_id, dealer_request_id, bid_id, to_timestamp(dr.created_at) as im_created_at,
                                    to_timestamp(dr.updated_at+interval '330 minutes') as im_updated_at, amount,
                                    dealer_rfc_amount, is_offer_accepted, dr.amount as rfc,
                                    dr.status, TECHNICAL_EVALUATION_UPDATED_AT, dr.dealer_complaint,
                                    case when request_reason = 'INSPECTION_MISS' AND dr.status =9 AND 
                                    Z1.ISSUE_TYPE not in ('ODOMETER_TAMPER' ,'Odometer(Km)') AND ((oe.BID_AT_BOUGHT <= 300000 AND dr.amount > 3000) 
                                    OR (oe.BID_AT_BOUGHT > 300000 AND dr.amount > 5000)) then 1 end as IM_Approve
                                    from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.DEALER_REQUESTS dr
                                    inner join (Select order_id, lead_id from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDERS) orders on orders.order_id = dr.fk_order_id
                                    left join (Select fk_dealer_request_id, issue_type from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.DEALER_REQUEST_ISSUE_TYPE)  z1 on dr.dealer_Request_id = z1.fk_dealer_request_id
                                    left join (Select fk_order_id, bid_at_bought from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDER_EXTRA) oe on oe.fk_order_id = dr.fk_order_id
                                    where REQUEST_REASON = 'INSPECTION_MISS'
                                    ) a
                              ) a
                        ) a 
                        where rank=1