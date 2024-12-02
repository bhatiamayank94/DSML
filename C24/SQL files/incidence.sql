select appointment_id,
-- inspection_data,

    -- Clutch Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch:additionalInfo[0]:currentCondition:value) LIKE '%HARD%' THEN 1 ELSE 0 END as clutch_hard_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch:additionalInfo[0]:currentCondition:value) LIKE '%SPONGY%' THEN 1 ELSE 0 END as clutch_spongy_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch:additionalInfo[0]:currentCondition:value) LIKE '%BURNING%' THEN 1 ELSE 0 END as clutch_burning_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch:additionalInfo[0]:currentCondition:value) LIKE '%BEARING NOISE%' THEN 1 ELSE 0 END as clutch_bearing_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch:additionalInfo[0]:currentCondition:value) LIKE '%SLIP/LOW PICKUP%' THEN 1 ELSE 0 END as clutch_slip_pickup_flag,



 -- Transmission and Gear Shifting Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%GEARBOX REPAIRED%' THEN 1 ELSE 0 END as transmission_gearbox_repaired_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%GEARBOX DAMAGED%' THEN 1 ELSE 0 END as transmission_gearbox_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%GEAR BOX ABNORMAL NOISE%' THEN 1 ELSE 0 END as transmission_abnormal_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%GEAR BOX OIL LEAKAGE%' THEN 1 ELSE 0 END as transmission_oil_leakage_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%GEAR SHIFTING HARD%' THEN 1 ELSE 0 END as transmission_hard_shifting_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%GEAR NOT ENGAGING%' THEN 1 ELSE 0 END as transmission_not_engaging_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%ABNORMAL NOISE WHILE SHIFTING%' THEN 1 ELSE 0 END as transmission_shift_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%AUTOMATIC TRANSMISSION NOT WORKING PROPERLY%' THEN 1 ELSE 0 END as auto_transmission_not_working_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%AUTOMATIC TRANSMISSION MIL LIGHT GLOWING%' THEN 1 ELSE 0 END as auto_transmission_mil_light_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting:additionalInfo[0]:currentCondition:value) LIKE '%4WD/AWD NOT WORKING%' THEN 1 ELSE 0 END as transmission_4wd_not_working_flag,


    -- Engine Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%REPAIRED%' THEN 1 ELSE 0 END as engine_repaired_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%REPLACED%' THEN 1 ELSE 0 END as engine_replaced_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%AIR FILTER BOX DAMAGED%' THEN 1 ELSE 0 END as engine_air_filter_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%ELECTRICAL WIRING DAMAGED%' THEN 1 ELSE 0 END as engine_wiring_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%LONG CRANKING DUE TO WEAK COMPRESSION%' THEN 1 ELSE 0 END as engine_weak_compression_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%LOW PICKUP DUE TO ENGINE PERFORMANCE%' THEN 1 ELSE 0 END as engine_low_pickup_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%RPM FLUCTUATING%' THEN 1 ELSE 0 END as engine_rpm_fluctuating_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%OVER HEATING%' THEN 1 ELSE 0 END as engine_overheating_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%MISFIRING%' THEN 1 ELSE 0 END as engine_misfiring_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%RPM NOT INCREASING%' THEN 1 ELSE 0 END as engine_rpm_not_increasing_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%MIL LIGHT GLOWING%' THEN 1 ELSE 0 END as engine_mil_light_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%LOW PRESSURE WARNING LIGHT GLOWING%' THEN 1 ELSE 0 END as engine_low_pressure_light_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine:additionalInfo[0]:currentCondition:value) LIKE '%FUEL LEAKAGE FROM INJECTOR%' THEN 1 ELSE 0 END as engine_fuel_injector_leak_flag,



    -- Engine Mounting Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineMounting:additionalInfo[0]:currentCondition:value) LIKE '%BROKEN%' THEN 1 ELSE 0 END as engine_mounting_broken_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineMounting:additionalInfo[0]:currentCondition:value) LIKE '%LOOSE%' THEN 1 ELSE 0 END as engine_mounting_loose_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineMounting:additionalInfo[0]:currentCondition:value) LIKE '%EXCESS VIBRATION%' THEN 1 ELSE 0 END as engine_mounting_vibration_flag,

    -- Turbocharger Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:turbocharger:additionalInfo[0]:currentCondition:value) LIKE '%TURBOCHARGER WHISTLING NOISE%' THEN 1 ELSE 0 END as turbocharger_whistling_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:turbocharger:additionalInfo[0]:currentCondition:value) LIKE '%TURBOCHARGER NOT WORKING%' THEN 1 ELSE 0 END as turbocharger_not_working_flag,

    -- Fuel Injector Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:fuelInjector:additionalInfo[0]:currentCondition:value) LIKE '%FUEL INJECTOR NOISE%' THEN 1 ELSE 0 END as fuel_injector_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:fuelInjector:additionalInfo[0]:currentCondition:value) LIKE '%LEAKAGE FROM FUEL INJECTOR OR MANIFOLD%' THEN 1 ELSE 0 END as fuel_injector_leakage_flag,

    -- Engine Sound & Blowby Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%NO ENGINE SOUND%' THEN 1 ELSE 0 END as engine_no_sound_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%CRITICAL SOUND%' THEN 1 ELSE 0 END as engine_critical_sound_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%1. NO BLOW BY%' THEN 1 ELSE 0 END as engine_idle_no_blowby_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%2. PERMISSIBLE BLOW BY ON IDLE%' THEN 1 ELSE 0 END as engine_idle_permissible_blowby_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%3. OIL SPILLAGE ON IDLE%' THEN 1 ELSE 0 END as engine_idle_oil_spillage_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%4. PERMISSIBLE BLOW BY & OIL SPILLAGE ON IDLE%' THEN 1 ELSE 0 END as engine_idle_permissible_blowby_spillage_flag,

    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%1. NO BLOW BY%' THEN 1 ELSE 0 END as engine_2000rpm_no_blowby_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%2. BLOW BY ON 2000 RPM%' THEN 1 ELSE 0 END as engine_2000rpm_blowby_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%3. OIL SPILLAGE ON 2000 RPM%' THEN 1 ELSE 0 END as engine_2000rpm_oil_spillage_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%4. BLOW BY & OIL SPILLAGE ON 2000 RPM%' THEN 1 ELSE 0 END as engine_2000rpm_blowby_spillage_flag,

    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%WATER PUMP NOISE%' THEN 1 ELSE 0 END as engine_water_pump_noise_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%TIMING BELT NOISE%' THEN 1 ELSE 0 END as engine_timing_belt_noise_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%TAPPET NOISE%' THEN 1 ELSE 0 END as engine_tappet_noise_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%ALTERNATOR BEARING NOISE%' THEN 1 ELSE 0 END as engine_alternator_bearing_noise_flag,
    -- CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value) LIKE '%TORSIONAL BEARING NOISE%' THEN 1 ELSE 0 END as engine_torsional_bearing_noise_flag







    -- Radiator Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:radiator:additionalInfo[0]:currentCondition:value) LIKE '%RADIATOR DAMAGED%' THEN 1 ELSE 0 END as radiator_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:radiator:additionalInfo[0]:currentCondition:value) LIKE '%RADIATOR FAN NOT WORKING%' THEN 1 ELSE 0 END as radiator_fan_not_working_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:radiator:additionalInfo[0]:currentCondition:value) LIKE '%RADIATOR FAN MOTOR NOISE%' THEN 1 ELSE 0 END as radiator_fan_noise_flag,

    -- Exhaust Smoke Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke:additionalInfo[0]:currentCondition:value) LIKE '%BLACK%' THEN 1 ELSE 0 END as exhaust_smoke_black_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke:additionalInfo[0]:currentCondition:value) LIKE '%BLUE%' THEN 1 ELSE 0 END as exhaust_smoke_blue_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke:additionalInfo[0]:currentCondition:value) LIKE '%WHITE%' THEN 1 ELSE 0 END as exhaust_smoke_white_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke:additionalInfo[0]:currentCondition:value) LIKE '%SILENCER ASSEMBLY DAMAGED%' THEN 1 ELSE 0 END as exhaust_silencer_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke:additionalInfo[0]:currentCondition:value) LIKE '%NOISE FROM SILENCER ASSEMBLY%' THEN 1 ELSE 0 END as exhaust_silencer_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke:additionalInfo[0]:currentCondition:value) LIKE '%CATALYTIC CONVERTER MISSING%' THEN 1 ELSE 0 END as exhaust_catalytic_missing_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke:additionalInfo[0]:currentCondition:value) LIKE '%OIL/COOLANT COMING FROM EXHAUST TAIL PIPE%' THEN 1 ELSE 0 END as exhaust_oil_coolant_leak_flag,

  


from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" 
where inspection_end_time::Date >= (getdate()::date - 3) 
