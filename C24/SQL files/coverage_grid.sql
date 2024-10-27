select qc.appointment_id,
    updated_at::Date as qc_log_date,
    updated_at::time as qc_log_time,
    response_data :data :rc :carColour :isIncorrect as carColour_response,
    response_data :data :rc :chassisNumber :isIncorrect as chassisNumber_response,
    response_data :data :rc :customerName :isIncorrect as customerName_response,
    response_data :data :rc :fitnessUpto :isIncorrect as fitnessUpto_response,
    response_data :data :rc :fuelType :isIncorrect as fuelType_response,
    response_data :data :rc :make :isIncorrect as make_response,
    response_data :data :rc :model :isIncorrect as model_response,
    response_data :data :rc :month :isIncorrect as month_response,
    response_data :data :rc :ownerNumber :isIncorrect as ownerNumber_response,
    response_data :data :rc :registrationCity :isIncorrect as registrationCity_response,
    response_data :data :rc :registrationNumber :isIncorrect as registrationNumber_response,
    response_data :data :rc :registrationDate :isIncorrect as registrationDate_response,
    response_data :data :rc :registrationState :isIncorrect as registrationState_response,
    response_data :data :rc :variant :isIncorrect as variant_response,
    response_data :data :rc :year :isIncorrect as year_response,
    response_data :data :rc :roadTaxPaid :isIncorrect as roadTaxPaid_response,
    response_data :data :rc :registrationState :subParts :rto :isIncorrect as rto_response,
    response_data :data :rc :roadTaxPaid :subParts :roadTaxDateValidity :isIncorrect as tax_paid_upto_response,
    PARSE_JSON(response_data) :"data" :"insurance" :"mismatchInInsurance" :"Chassis Number" :"isIncorrect"::varchar as insurancemismatch_chassis_number_response,
    PARSE_JSON(response_data) :"data" :"insurance" :"mismatchInInsurance" :"Customer Name" :"isIncorrect"::varchar as insurancemismatch_customer_name_response,
    PARSE_JSON(response_data) :"data" :"insurance" :"mismatchInInsurance" :"Engine Number" :"isIncorrect"::varchar as insurancemismatch_engine_number_response,
    PARSE_JSON(response_data) :"data" :"insurance" :"mismatchInInsurance" :"Fuel Type" :"isIncorrect"::varchar as insurancemismatch_fuel_type_response,
    PARSE_JSON(response_data) :"data" :"insurance" :"mismatchInInsurance" :"Make/Model" :"isIncorrect"::varchar as insurancemismatch_make_model_response,
    response_data :data :insurance :insuranceType :isIncorrect::varchar as insuranceType_isincorrect,
    response_data :data :insurance :insuranceExpiry :isIncorrect::varchar as insurance_expiry_isincorrect,
    response_data :data :insurance :noClaimBonus :isIncorrect::varchar as noClaimBonus_isincorrect,
    response_data :data :insurance :noClaimBonusPercentage :isIncorrect::varchar as noClaimBonusPercentage_isincorrect,

----- v3
    response_data :data :rc :cngLpgFitment :isIncorrect as cngLpgFitment_response,
    response_data :data :rc :financierName :isIncorrect as cngLpgFitment_response,


from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_DS_QC_LOG qc
where qc_log_date >= getdate()::Date - 2;


select qc.appointment_id,
    updated_at::Date as qc_log_date,
    updated_at::time as qc_log_time,
    response_data :data :rc :cngLpgFitment :isIncorrect as cngLpgFitment_response,
    response_data :data :rc :financierName :isIncorrect as cngLpgFitment_response,


from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_DS_QC_LOG qc
where qc_log_date >= getdate()::Date - 10

