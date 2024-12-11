select appointment_id,
        inspection_by,
        inspection_end_time::date as insp_date,
        inspection_data:exteriorTyres:rhsFrontTyre:additionalInfo[0]:image:url::varchar as rhsFrontTyre,
        inspection_data:exteriorTyres:lhsFrontTyre:additionalInfo[0]:image:url::varchar as lhsFrontTyre,
        inspection_data:exteriorTyres:rhsRearTyre:additionalInfo[0]:image:url::varchar as rhsRearTyre,
        inspection_data:exteriorTyres:lhsRearTyre:additionalInfo[0]:image:url::varchar as lhsRearTyre                        


from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where inspection_end_time::Date >='2024-11-30'
and version=0 
and inspection_status in ('done')

;

-- PCM


select appointment_id,
        inspection_by,
        -- inspection_end_time::Date as insp_date,
        case when upper(inspection_data:carDetails:additionalImages[0]:hashKey::varchar) in ('INSPECTIONDATA_CARDETAILS_ADDITIONALIMAGES_ADDRESSPROOF')
                then inspection_data:carDetails:additionalImages[0]:url::varchar
                when upper(inspection_data:carDetails:additionalImages[1]:hashKey::varchar) in ('INSPECTIONDATA_CARDETAILS_ADDITIONALIMAGES_ADDRESSPROOF')
                then inspection_data:carDetails:additionalImages[1]:url::varchar
                when upper(inspection_data:carDetails:additionalImages[2]:hashKey::varchar) in ('INSPECTIONDATA_CARDETAILS_ADDITIONALIMAGES_ADDRESSPROOF')
                then inspection_data:carDetails:additionalImages[2]:url::varchar
                when upper(inspection_data:carDetails:additionalImages[3]:hashKey::varchar) in ('INSPECTIONDATA_CARDETAILS_ADDITIONALIMAGES_ADDRESSPROOF')
                then inspection_data:carDetails:additionalImages[3]:url::varchar
                when upper(inspection_data:carDetails:additionalImages[4]:hashKey::varchar) in ('INSPECTIONDATA_CARDETAILS_ADDITIONALIMAGES_ADDRESSPROOF')
                then inspection_data:carDetails:additionalImages[4]:url::varchar
                when upper(inspection_data:carDetails:additionalImages[5]:hashKey::varchar) in ('INSPECTIONDATA_CARDETAILS_ADDITIONALIMAGES_ADDRESSPROOF')
                then inspection_data:carDetails:additionalImages[5]:url::varchar
                when upper(inspection_data:carDetails:additionalImages[6]:hashKey::varchar) in ('INSPECTIONDATA_CARDETAILS_ADDITIONALIMAGES_ADDRESSPROOF')
                then inspection_data:carDetails:additionalImages[6]:url::varchar
                when upper(inspection_data:carDetails:additionalImages[7]:hashKey::varchar) in ('INSPECTIONDATA_CARDETAILS_ADDITIONALIMAGES_ADDRESSPROOF')
                then inspection_data:carDetails:additionalImages[7]:url::varchar
                else null end as Paint coat meter,
        -- inspection_data


from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"  
where inspection_end_time::Date = (getdate()::date -21)
and version=0
and upper(inspection_status) in ('DONE')




