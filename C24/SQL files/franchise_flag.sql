select cj._id,
        cj.status as cj_status,
        cj.week_off_day as cj_week_off_day,
        cj.email as cj_email,
        cj.date_of_joining::date cj_joining_date,
        cj.store_id,
        case when fran.store_id is not null then 'franchise' else 'non franchise' end as cj_franchise_flag

from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_CJ_LIST cj 
left join 
(select distinct store_id from ETL.DERIVED_DATA.FRANCHISE_ANALYTICS_SUPERSET_DATA_QUERY_RESULTS
Where appt_id_flag in ('Y')
and launch_date <= '2025-12-31'
) fran on cj.store_id=fran.store_id

where upper(cj.status) in ('ACTIVE')