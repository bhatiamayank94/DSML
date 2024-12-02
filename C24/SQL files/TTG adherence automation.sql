select appointment_id,
        inspection_by,
        inspection_end_time::date as insp_date,
        inspection_data:exteriorTyres:rhsFrontTyre:additionalInfo[0]:image:url::varchar as rhsFrontTyre,
        inspection_data:exteriorTyres:lhsFrontTyre:additionalInfo[0]:image:url::varchar as lhsFrontTyre,
        inspection_data:exteriorTyres:rhsRearTyre:additionalInfo[0]:image:url::varchar as rhsRearTyre,
        inspection_data:exteriorTyres:lhsRearTyre:additionalInfo[0]:image:url::varchar as lhsRearTyre                        


from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where inspection_end_time::Date >=getdate()::DAte - 7
and version=0 
and inspection_status in ('done')

