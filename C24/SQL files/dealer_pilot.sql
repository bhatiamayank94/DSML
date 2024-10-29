select OB.DEALER_CODE,
        OB.ONBOARDING_DATE::date as ONBOARDING_DATE,
        OB.REGION,
        DEALER_ID,
        DEALERSHIP_NAME,


from PC_STITCH_DB.FIVETRAN1_BI.DEALER_ONBOARDING OB
left join PC_STITCH_DB.FIVETRAN1_BI.CDD cdd on  TO_CHAR(OB.DEALER_CODE)=TO_CHAR(cdd.DEALER_CODE)
where (onboarding_date::Date >= '2024-10-17')
or (upper(ob.region) in ('MUMBAI'))



;
