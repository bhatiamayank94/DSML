select OB.DEALER_CODE,
    OB.ONBOARDING_DATE::date as ONBOARDING_DATE,
    OB.REGION,
    cdd.DEALER_ID,
    DEALERSHIP_NAME,
    case
        when act_dealers.active_dealers is not null
        or OB.ONBOARDING_DATE::date >= (getdate()::Date - 60) then 1
        else 0
    end as active_dealer_flag
from PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING OB
    left join PC_STITCH_DB.FIVETRAN1_BI.CDD cdd on TO_CHAR(OB.DEALER_CODE) = TO_CHAR(cdd.DEALER_CODE)
    left join (
        select distinct sale_confirmed_fk_dealer_id as active_dealers,
            from PC_STITCH_DB.ADMIN_PANEL_PROD_DEALERENGINE_PROD.ORDER_SALE_REQUEST
        where gfd_at::Date >= (getdate()::Date - 180)
    ) act_dealers on cdd.DEALER_ID = act_dealers.active_dealers 
    -- where (onboarding_date::Date >= '2024-10-17')
    -- or (upper(ob.region) in ('MUMBAI'));







