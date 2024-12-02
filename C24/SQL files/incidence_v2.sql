select appointment_id,  
inspection_end_time::Date as insp_date,
version,
inspection_status,

-- Engine oil level Dipstick
case when inspection_Data:engineTransmission:engineOilLevelDipstik:value not in ('Yes') then 1 else 0 end as engineTransmission_engineOilLevelDipstik

-- Engine Oil
,case when inspection_Data:engineTransmission:engineOil:value not in ('Yes') then 1 else 0 end as engineTransmission_engineOil

-- Coolant
,case when inspection_Data:engineTransmission:coolant:value not in ('Yes') then 1 else 0 end as engineTransmission_coolant

-- Sump
,case when inspection_Data:engineTransmission:sump:value not in ('Yes') then 1 else 0 end as engineTransmission_sump

-- Battery & Alternator
,case when inspection_Data:engineTransmission:battery:value not in ('Yes') then 1 else 0 end as engineTransmission_battery

-- Is the car running perfectly (Engine Sound)
,case when inspection_Data:engineTransmission:engineSound:value not in ('Yes') then 1 else 0 end as engineTransmission_engineSound

-- Clutch
,case when inspection_Data:engineTransmission:clutch:value not in ('Yes') then 1 else 0 end as engineTransmission_clutch

-- Transmission and Gear Shifting
,case when inspection_Data:engineTransmission:gearShifting:value not in ('Yes') then 1 else 0 end as engineTransmission_gearShifting

-- Engine
,case when inspection_Data:engineTransmission:engine:value not in ('Yes') then 1 else 0 end as engineTransmission_engine

-- Engine Mounting
,case when inspection_Data:engineTransmission:engineMounting:value not in ('Yes') then 1 else 0 end as engineTransmission_engineMounting

-- Turbocharger
,case when inspection_Data:engineTransmission:turboCharger:value not in ('Yes') then 1 else 0 end as engineTransmission_turboCharger

-- Fuel Injector
,case when inspection_Data:engineTransmission:fuelInjector:value not in ('Yes') then 1 else 0 end as engineTransmission_fuelInjector

-- Engine Sound & Blowby
,case when inspection_Data:engineTransmission:engineSound:value not in ('Yes') then 1 else 0 end as engineTransmission_engineSound_blowby

-- Radiator
,case when inspection_Data:engineTransmission:radiator:value not in ('Yes') then 1 else 0 end as engineTransmission_radiator

-- Exhaust smoke
,case when inspection_Data:engineTransmission:exhaustSmoke:value not in ('Yes') then 1 else 0 end as engineTransmission_exhaustSmoke

-- Comments
,case when inspection_Data:engineTransmission:comments is null then 1 else 0 end as engineTransmission_comments,


    -- Engine Oil Level Dipstick Flags
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineOilLevelDipstik) LIKE '%BROKEN%'
            or UPPER(inspection_Data:engineTransmission:engineOilLevelDipstik) LIKE '%MISSING%'  THEN 1  ELSE 0 END AS engine_oil_dipstick_broken_missing_flag,

    -- Engine Oil Flags
    case when upper(inspection_Data:engineTransmission:engineOil) like ('%MIXED%WITH%COOLANT%') then 1 else 0 end as engine_oil_mixed_with_coolant_flag,
    case when upper(inspection_Data:engineTransmission:engineOil) like ('%LEAKAGE%FROM%SIDE%COVER%') then 1 else 0 end as engine_oil_leakage_from_side_cover_flag,
    case when upper(inspection_Data:engineTransmission:engineOil) like ('%LEAKAGE%FROM%INTERCOOLER%') then 1 else 0 end as engine_oil_leakage_from_intercooler_flag,
    case when upper(inspection_Data:engineTransmission:engineOil) like ('%LEAKAGE%FROM%TURBO%') then 1 else 0 end as engine_oil_leakage_from_turbocharger_flag,
    case when upper(inspection_Data:engineTransmission:engineOil) like ('%LEAKAGE%FROM%TAPPET%COVER%') then 1 else 0 end as engine_oil_leakage_from_tappet_cover_flag,
    case when upper(inspection_Data:engineTransmission:engineOil) like ('%DIRTY%') then 1 else 0 end as engine_oil_dirty_flag,
    case when upper(inspection_Data:engineTransmission:engineOil) like ('%LEAKING%') then 1 else 0 end as engine_oil_leaking_flag,
    case when upper(inspection_Data:engineTransmission:engineOil) like ('%LEVEL%LOW%') then 1 else 0 end as engine_oil_level_low_flag,

    -- Coolant Flags
    case when upper(inspection_Data:engineTransmission:coolant) like ('%DIRTY%') then 1 else 0 end as coolant_dirty_flag,
    case when upper(inspection_Data:engineTransmission:coolant) like ('%LEAKING%') then 1 else 0 end as coolant_leaking_flag,
    case when upper(inspection_Data:engineTransmission:coolant) like ('%LEVEL%LOW%') then 1 else 0 end as coolant_leaking_flag,
    case when upper(inspection_Data:engineTransmission:coolant) like ('%COOLANT%MIXED%WITH%ENGINE%OIL%') then 1 else 0 end as coolant_mixed_with_engine_oil_flag,

    -- Sump Flags
    case when upper(inspection_Data:engineTransmission:sump) like ('%DAMAGED%WITH%MINOR%LEAKAGE%') then 1 else 0 end as sump_damaged_with_minor_leakage_flag,
    case when upper(inspection_Data:engineTransmission:sump) like ('%DAMAGED%WITH%HEAVY%LEAKAGE%') then 1 else 0 end as sump_damaged_with_heavy_leakage_flag,
    case when upper(inspection_Data:engineTransmission:sump) like ('%DAMAGED%WITHOUT%LEAKAGE%') then 1 else 0 end as sump_damaged_without_leakage_flag,
    case when upper(inspection_Data:engineTransmission:sump) like ('%LEAKAGE%NO%DAMAGE%') then 1 else 0 end as sump_leakage_no_damage_flag,

    -- Battery & Alternator Flags
    case when upper(inspection_Data:engineTransmission:battery) like ('%DISCHARGING%LIGHT%GLOWING%') then 1 else 0 end as battery_discharging_light_glowing_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%DAMAGED%') then 1 else 0 end as battery_damaged_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%BATTERY%NOT%AVAILABLE%') then 1 else 0 end as battery_not_available_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%DEAD%') then 1 else 0 end as battery_dead_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%JUMP%START%') then 1 else 0 end as battery_jump_start_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%BATTERY%DAMAGED%') then 1 else 0 end as battery_damage_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%ACID%LEAKAGE%') then 1 else 0 end as battery_acid_leakage_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%WEAK%') then 1 else 0 end as battery_weak_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%ALTERNATOR%BELT%DAMAGED%') then 1 else 0 end as battery_alternator_belt_damage_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%WEAK%DEAD%') then 1 else 0 end as battery_weak_or_dead_flag,
    case when upper(inspection_Data:engineTransmission:battery) like ('%BATTERY%TERMINAL%BROKEN%') then 1 else 0 end as battery_terminal_broken_flag,

    -- Car Condition/comments

    case when upper(inspection_Data:engineTransmission:comments) like ('%CAR%WORKING%CONDITION%TOWING%DAMAGE%ENGINE%')   then 1 else 0 end as engine_working_towing_to_avoid_engine_damage_flag,
    case when upper(inspection_Data:engineTransmission:comments) like ('%CAR%NOT%RUNNING%CONDITION%TOWING%')    then 1 else 0 end as not_running_condition_flag,
    case when upper(inspection_Data:engineTransmission:comments) like ('%ENGINE%STARTING%NOT%RUNNING%CONDITION%TOWING%REQUIRED%')    then 1 else 0 end as engine_working_car_not_in_running_flag,
    case when upper(inspection_Data:engineTransmission:comments) like ('%CAR%WORKING%CONDITION%TOWING%DAMAGE%CLUTCH%')     then 1 else 0 end as engine_working_towing_to_avoid_clutch_damage_flag,
    case when upper(inspection_Data:engineTransmission:comments) like ('%SEIZED%')  then 1 else 0 end as engine_seized_flag,
    case when upper(inspection_Data:engineTransmission:comments) like ('%STARTER%SOLENOID%')  then 1 else 0 end as engine_starter_motor_solenoid_malfunction_flag,

    

    -- Clutch Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch) LIKE '%HARD%' THEN 1 ELSE 0 END as clutch_hard_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch) LIKE '%SPONGY%' THEN 1 ELSE 0 END as clutch_spongy_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch) LIKE '%BURNING%' THEN 1 ELSE 0 END as clutch_burning_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch) LIKE '%BEARING NOISE%' THEN 1 ELSE 0 END as clutch_bearing_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:clutch) LIKE ('%SLIP%LOW%PICK%') THEN 1 ELSE 0 END as clutch_slip_pickup_flag,



 -- Transmission and Gear Shifting Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%GEARBOX REPAIRED%' THEN 1 ELSE 0 END as transmission_gearbox_repaired_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%GEARBOX DAMAGED%' THEN 1 ELSE 0 END as transmission_gearbox_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%GEAR BOX ABNORMAL NOISE%' THEN 1 ELSE 0 END as transmission_abnormal_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%GEAR BOX OIL LEAKAGE%' THEN 1 ELSE 0 END as transmission_oil_leakage_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%GEAR SHIFTING HARD%' THEN 1 ELSE 0 END as transmission_hard_shifting_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%GEAR NOT ENGAGING%' THEN 1 ELSE 0 END as transmission_not_engaging_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%ABNORMAL NOISE WHILE SHIFTING%' THEN 1 ELSE 0 END as transmission_shift_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%AUTOMATIC TRANSMISSION NOT WORKING PROPERLY%' THEN 1 ELSE 0 END as auto_transmission_not_working_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%AUTOMATIC TRANSMISSION MIL LIGHT GLOWING%' THEN 1 ELSE 0 END as auto_transmission_mil_light_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:gearShifting) LIKE '%4WD/AWD NOT WORKING%' THEN 1 ELSE 0 END as transmission_4wd_not_working_flag,


    -- Engine Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%REPAIRED%' THEN 1 ELSE 0 END as engine_repaired_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%REPLACED%' THEN 1 ELSE 0 END as engine_replaced_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%AIR FILTER BOX DAMAGED%' THEN 1 ELSE 0 END as engine_air_filter_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%ELECTRICAL WIRING DAMAGED%' THEN 1 ELSE 0 END as engine_wiring_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%LONG CRANKING DUE TO WEAK COMPRESSION%' THEN 1 ELSE 0 END as engine_weak_compression_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%LOW PICKUP DUE TO ENGINE PERFORMANCE%' THEN 1 ELSE 0 END as engine_low_pickup_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%RPM FLUCTUATING%' THEN 1 ELSE 0 END as engine_rpm_fluctuating_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%OVER HEATING%' THEN 1 ELSE 0 END as engine_overheating_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%MISFIRING%' THEN 1 ELSE 0 END as engine_misfiring_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%RPM NOT INCREASING%' THEN 1 ELSE 0 END as engine_rpm_not_increasing_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%MIL LIGHT GLOWING%' THEN 1 ELSE 0 END as engine_mil_light_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%LOW PRESSURE WARNING LIGHT GLOWING%' THEN 1 ELSE 0 END as engine_low_pressure_light_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engine) LIKE '%FUEL LEAKAGE FROM INJECTOR%' THEN 1 ELSE 0 END as engine_fuel_injector_leak_flag,

    -- Engine Mounting Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineMounting) LIKE '%BROKEN%' THEN 1 ELSE 0 END as engine_mounting_broken_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineMounting) LIKE '%LOOSE%' THEN 1 ELSE 0 END as engine_mounting_loose_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineMounting) LIKE '%EXCESS VIBRATION%' THEN 1 ELSE 0 END as engine_mounting_vibration_flag,

    -- Turbocharger Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:turboCharger) LIKE '%TURBOCHARGER%WHISTLING%' THEN 1 ELSE 0 END as turbocharger_whistling_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:turboCharger) LIKE '%TURBOCHARGER%NOT%WORKING%' THEN 1 ELSE 0 END as turbocharger_not_working_flag,
 
    -- Fuel Injector Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:fuelInjector) LIKE '%FUEL INJECTOR NOISE%' THEN 1 ELSE 0 END as fuel_injector_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:fuelInjector) LIKE '%LEAKAGE FROM FUEL INJECTOR OR MANIFOLD%' THEN 1 ELSE 0 END as fuel_injector_leakage_flag,

    -- Engine Sound
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%CRITICAL%') then 1 else 0 end as engine_sound_critical_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%MAJOR%') then 1 else 0 end as engine_sound_major_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%NO%SOUND%') then 1 else 0 end as engine_sound_no_sound_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%TIMING%BELT%NOISE%') 
                OR UPPER(inspection_Data:engineTransmission:engineSound) like ('%WATER%PUMP%NOISE%')
                OR UPPER(inspection_Data:engineTransmission:engineSound) like ('%ALTERNATOR%BEARING%NOISE%')
                OR UPPER(inspection_Data:engineTransmission:engineSound) like ('%MINOR%')  then 1 else 0 end as engine_sound_minor_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%ALTERNATOR%BEARING%NOISE%') then 1 else 0 end as engine_sound_alternator_bearing_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%WATER%PUMP%NOISE%') then 1 else 0 end as engine_sound_water_pump_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%TIMING%BELT%NOISE%') then 1 else 0 end as engine_sound_timing_belt_noise_flag,

  -- Idle blow by 

    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%OIL%SPILLAGE%IDLE%') then 1 else 0 end as engine_blowby_idle_oil_spillage_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%PERMISSIBLE%BLOW%SPILLAGE%IDLE%') then 1 else 0 end as engine_blowby_idle_permissible_blowby_oil_spillage_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%NO%BLOW%') then 1 else 0 end as engine_blowby_no_blow_by_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%%PERMISSIBLE%BLOW%IDLE%') then 1 else 0 end as engine_blowby_idle_permissible_blowby_flag,
 
 -- 2000 RPM blow by 

    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%OIL%SPILLAGE%2000%') then 1 else 0 end as engine_blowby_2K_oil_spillage_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%BLOW%SPILLAGE%2000%') then 1 else 0 end as engine_blowby_2K_blowby_oil_spillage_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%NO%BLOW%') then 1 else 0 end as engine_blowby_2K_no_blow_by_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:engineSound) like ('%%PERMISSIBLE%BLOW%IDLE%') then 1 else 0 end as engine_blowby_2K_blowby_flag,


    -- Radiator Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:radiator) LIKE '%RADIATOR DAMAGED%' THEN 1 ELSE 0 END as radiator_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:radiator) LIKE '%RADIATOR FAN NOT WORKING%' THEN 1 ELSE 0 END as radiator_fan_not_working_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:radiator) LIKE '%RADIATOR FAN MOTOR NOISE%' THEN 1 ELSE 0 END as radiator_fan_noise_flag,

    -- Exhaust Smoke Conditions
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke) LIKE '%BLACK%' THEN 1 ELSE 0 END as exhaust_smoke_black_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke) LIKE '%BLUE%' THEN 1 ELSE 0 END as exhaust_smoke_blue_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke) LIKE '%WHITE%' THEN 1 ELSE 0 END as exhaust_smoke_white_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke) LIKE '%SILENCER ASSEMBLY DAMAGED%' THEN 1 ELSE 0 END as exhaust_silencer_damaged_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke) LIKE '%NOISE FROM SILENCER ASSEMBLY%' THEN 1 ELSE 0 END as exhaust_silencer_noise_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke) LIKE '%CATALYTIC CONVERTER MISSING%' THEN 1 ELSE 0 END as exhaust_catalytic_missing_flag,
    CASE WHEN UPPER(inspection_Data:engineTransmission:exhaustSmoke) LIKE '%OIL%COOLANT%EXHAUST%' THEN 1 ELSE 0 END as exhaust_oil_coolant_leak_flag,


from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" 
where inspection_end_time::Date >= (getdate()::date - 10)
and inspection_status in ('done') ;




-- select appointment_id,
-- case when upper(inspection_Data:engineTransmission:engineSound:additionalInfo) like ('%ALTERNATOR%BEARING%NOISE%') then 1 else 0 end as
--         engine_transmission_enginesound_alternator_bearing_noise_flag,
-- case when upper(inspection_Data:engineTransmission:engineSound:additionalInfo) like ('%TAPPET%NOISE%') then 1 else 0 end as
--              engine_transmission_enginesound_tappet_noise_flag,
-- case when upper(inspection_Data:engineTransmission:engineSound:additionalInfo) like ('%TIMING%BELT%NOISE%') then 1 else 0 end as
--              engine_transmission_enginesound_timing_belt_noise_flag,
-- case when upper(inspection_Data:engineTransmission:engineSound:additionalInfo) like ('%WATER%PUMP%NOISE%') then 1 else 0 end as
--              engine_transmission_enginesound_water_pump_noise_flag,
-- from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

-- ;

;


select appointment_id
        ,inspection_data
from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" 
where inspection_end_time::Date >= (getdate()::date - 10)
and year<=2010 and upper(inspection_Data:engineTransmission:battery:value) like ('%NO%')
limit 15
;





select appointment_id, inspection_data
from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where inspection_end_time::Date >= (getdate()::date - 10) and upper(inspection_Data:engineTransmission) like '%SOLENOID%'
limit 5;


select distinct inspection_Data:engineTransmission:engineSound:additionalInfo[0]:currentCondition:value[0]

from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where inspection_end_time::Date >= (getdate()::date - 10)
and inspection_Data:engineTransmission:engineSound:additionalInfo[0]:hashKey in ('engineTransmission_engineSound_additionalInfo_form_2')

;

;
select distinct inspection_Data:engineTransmission:coolant:additionalInfo[0]:currentCondition:value[0]

from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"

where inspection_end_time::Date >= (getdate()::date - 10)
limit 5