SELECT appointment_id,
    request_data :storeId::int as store_id,
    created_at::date as date,
    -- response_data
    -- Running borders
        response_data :or_flags.exteriorTyres.runningBorder.subParts.lhs.currentCondition.value AS runningBorder_lhs_condition_values,
        response_data :or_flags.exteriorTyres.runningBorder.subParts.lhs.flag AS runningBorder_lhs_flag,
        response_data :or_flags.exteriorTyres.runningBorder.subParts.lhs.severityScaleCC.value AS runningBorder_lhs_severity_scale_values,
        request_data :inspectionData :exteriorTyres.elements.runningBorder.subParts.lhs.value::STRING as running_border_lhs_cj,
        request_data :inspectionData :exteriorTyres.elements.runningBorder.subParts.lhs.additionalInfo [0].currentCondition.value [0]::STRING as running_border_lhs_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.runningBorder.subParts.lhs.additionalInfo [0].severityScaleCC.value :Dented::NUMBER as running_border_lhs_severity_cj,
        request_data :inspectionData :exteriorTyres.elements.runningBorder.subParts.rhs.value::STRING as running_border_rhs_cj,
        request_data :inspectionData :exteriorTyres.elements.runningBorder.subParts.rhs.additionalInfo [0].currentCondition.value [0]::STRING as running_border_rhs_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.runningBorder.subParts.rhs.additionalInfo [0].severityScaleCC.value :Dented::NUMBER as running_border_rhs_severity_cj,
    -- Doors
        response_data :or_flags.exteriorTyres.doors.subParts.lhsFront.currentCondition.value AS lhsFront_condition_values,
        response_data :or_flags.exteriorTyres.doors.subParts.lhsFront.flag AS lhsFront_flag,
        response_data :or_flags.exteriorTyres.doors.subParts.lhsFront.severityScaleCC.value AS lhsFront_severity_scale_values,
        response_data :or_flags.exteriorTyres.doors.subParts.lhsRear.currentCondition.value AS lhsRear_condition_values,
        response_data :or_flags.exteriorTyres.doors.subParts.lhsRear.flag AS lhsRear_flag,
        response_data :or_flags.exteriorTyres.doors.subParts.lhsRear.severityScaleCC.value AS lhsRear_severity_scale_values,
        response_data :or_flags.exteriorTyres.doors.subParts.rhsFront.currentCondition.value AS rhsFront_condition_values,
        response_data :or_flags.exteriorTyres.doors.subParts.rhsFront.flag AS rhsFront_flag,
        response_data :or_flags.exteriorTyres.doors.subParts.rhsFront.severityScaleCC.value AS rhsFront_severity_scale_values,
        response_data :or_flags.exteriorTyres.doors.subParts.rhsRear.currentCondition.value AS rhsRear_condition_values,
        response_data :or_flags.exteriorTyres.doors.subParts.rhsRear.flag AS rhsRear_flag,
        response_data :or_flags.exteriorTyres.doors.subParts.rhsRear.severityScaleCC.value AS rhsRear_severity_scale_values,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.lhsFront.value::STRING as door_lhs_front_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.lhsFront.additionalInfo [0].currentCondition.value [0]::STRING as door_lhs_front_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.lhsFront.additionalInfo [0].severityScaleCC.value :Scratched::NUMBER as door_lhs_front_severity_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.lhsRear.value::STRING as door_lhs_rear_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.lhsRear.additionalInfo [0].currentCondition.value::ARRAY as door_lhs_rear_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.lhsRear.additionalInfo [0].severityScaleCC.value::OBJECT as door_lhs_rear_severity_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.rhsFront.value::STRING as door_rhs_front_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.rhsFront.additionalInfo [0].currentCondition.value [0]::STRING as door_rhs_front_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.rhsFront.additionalInfo [0].severityScaleCC.value :Scratched::NUMBER as door_rhs_front_severity_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.rhsRear.value::STRING as door_rhs_rear_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.rhsRear.additionalInfo [0].currentCondition.value::ARRAY as door_rhs_rear_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.doors.subParts.rhsRear.additionalInfo [0].severityScaleCC.value::OBJECT as door_rhs_rear_severity_cj,
    -- Quarter panels
        response_data :or_flags.exteriorTyres.quarterPanel.subParts.lhs.currentCondition.value AS quarterPanel_lhs_condition_values,
        response_data :or_flags.exteriorTyres.quarterPanel.subParts.lhs.flag AS quarterPanel_lhs_flag,
        response_data :or_flags.exteriorTyres.quarterPanel.subParts.lhs.severityScaleCC.value AS quarterPanel_lhs_severity_scale_values,
        response_data :or_flags.exteriorTyres.quarterPanel.subParts.rhs.currentCondition.value AS quarterPanel_rhs_condition_values,
        response_data :or_flags.exteriorTyres.quarterPanel.subParts.rhs.flag AS quarterPanel_rhs_flag,
        response_data :or_flags.exteriorTyres.quarterPanel.subParts.rhs.severityScaleCC.value AS quarterPanel_rhs_severity_scale_values,
        request_data :inspectionData :exteriorTyres.elements.quarterPanel.subParts.lhs.value::STRING as quarter_panel_lhs_cj,
        request_data :inspectionData :exteriorTyres.elements.quarterPanel.subParts.lhs.additionalInfo [0].currentCondition.value [0]::STRING as quarter_panel_lhs_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.quarterPanel.subParts.lhs.additionalInfo [0].severityScaleCC.value :Dented::NUMBER as quarter_panel_lhs_severity_cj,
        request_data :inspectionData :exteriorTyres.elements.quarterPanel.subParts.rhs.value::STRING as quarter_panel_rhs_cj,
        request_data :inspectionData :exteriorTyres.elements.quarterPanel.subParts.rhs.additionalInfo [0].currentCondition.value::ARRAY as quarter_panel_rhs_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.quarterPanel.subParts.rhs.additionalInfo [0].severityScaleCC.value::OBJECT as quarter_panel_rhs_severity_cj,
    -- Fenders
        response_data :or_flags.exteriorTyres.fenders.subParts.lhs.currentCondition.value AS fenders_lhs_condition_values,
        response_data :or_flags.exteriorTyres.fenders.subParts.lhs.flag AS fenders_lhs_flag,
        response_data :or_flags.exteriorTyres.fenders.subParts.lhs.severityScaleCC.value AS fenders_lhs_severity_scale_values,
        response_data :or_flags.exteriorTyres.fenders.subParts.rhs.currentCondition.value AS fenders_rhs_condition_values,
        response_data :or_flags.exteriorTyres.fenders.subParts.rhs.flag AS fenders_rhs_flag,
        response_data :or_flags.exteriorTyres.fenders.subParts.rhs.severityScaleCC.value AS fenders_rhs_severity_scale_values,
        request_data :inspectionData :exteriorTyres.elements.fenders.subParts.lhs.value::STRING as fender_lhs_cj,
        request_data :inspectionData :exteriorTyres.elements.fenders.subParts.lhs.additionalInfo [0].currentCondition.value [0]::STRING as fender_lhs_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.fenders.subParts.lhs.additionalInfo [0].severityScaleCC.value :Dented::NUMBER as fender_lhs_severity_cj,
        request_data :inspectionData :exteriorTyres.elements.fenders.subParts.rhs.value::STRING as fender_rhs_cj,
        request_data :inspectionData :exteriorTyres.elements.fenders.subParts.rhs.additionalInfo [0].currentCondition.value [0]::STRING as fender_rhs_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.fenders.subParts.rhs.additionalInfo [0].severityScaleCC.value :Scratched::NUMBER as fender_rhs_severity_cj,
    -- ORVM (Outside Rear View Mirror)
        response_data :or_flags.exteriorTyres :orvm :subParts :lhs :flag::number as orvm_lhs_flag,
        response_data :or_flags.exteriorTyres :orvm :subParts :lhs :currentCondition :value as orvm_lhs_flag,
        request_data :inspectionData :exteriorTyres.elements.orvm.subParts.lhs.value::STRING as orvm_lhs_cj,
        request_data :inspectionData :exteriorTyres.elements.orvm.subParts.lhs.additionalInfo [0].currentCondition.value [0]::STRING as orvm_lhs_condition_cj,
        response_data :or_flags.exteriorTyres :orvm :subParts :rhs :flag::number as orvm_rhs_flag,
        response_data :or_flags.exteriorTyres :orvm :subParts :rhs :currentCondition :value as orvm_rhs_flag,
        request_data :inspectionData :exteriorTyres.elements.orvm.subParts.rhs.value::STRING as orvm_rhs_cj,
        request_data :inspectionData :exteriorTyres.elements.orvm.subParts.rhs.additionalInfo [0].currentCondition.value [0]::STRING as orvm_rhs_condition_cj,
    -- Headlights
        response_data :or_flags.exteriorTyres :lights :subParts :lhsHeadlight :flag::number as lhs_headlight_flag,
        response_data :or_flags.exteriorTyres :lights :subParts :lhsHeadlight :currentCondition :value as lhs_headlight_flag_condition_values,
        request_data :inspectionData :exteriorTyres.elements.lights.subParts.lhsHeadlight.value::STRING as headlight_lhs_cj,
        request_data :inspectionData :exteriorTyres.elements.lights.subParts.lhsHeadlight.additionalInfo [0].currentCondition.value [0]::STRING as headlight_lhs_condition_cj,
        response_data :or_flags.exteriorTyres :lights :subParts :rhsHeadlight :flag::number as rhs_headlight_flag,
        response_data :or_flags.exteriorTyres :lights :subParts :rhsHeadlight :currentCondition :value as rhs_headlight_flag_condition_values,
        request_data :inspectionData :exteriorTyres.elements.lights.subParts.rhsHeadlight.value::STRING as headlight_rhs_cj,
        request_data :inspectionData :exteriorTyres.elements.lights.subParts.rhsHeadlight.additionalInfo [0].currentCondition.value [0]::STRING as headlight_rhs_condition_cj,
    -- Taillights
        request_data :inspectionData :exteriorTyres.elements.lights.subParts.lhsTaillight.value::STRING as taillight_lhs_cj,
        request_data :inspectionData :exteriorTyres.elements.lights.subParts.lhsTaillight.additionalInfo [0].currentCondition.value [0]::STRING as taillight_lhs_condition_cj,
        request_data :inspectionData :exteriorTyres.elements.lights.subParts.rhsTaillight.value::STRING as taillight_rhs_cj,
        request_data :inspectionData :exteriorTyres.elements.lights.subParts.rhsTaillight.additionalInfo [0].currentCondition.value [0]::STRING as taillight_rhs_condition_cj
from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_LIKELIHOOD_DATA_LOG
where created_at::date >= '2024-09-01'
    and request_data :storeId::int in (1985) -- and response_data:or_flags.exteriorTyres:lights:subParts is not null
;







select * from 
PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_LIKELIHOOD_DATA_LOG

where  appointment_id in ('10102929798','10179933764');


select  *
from PC_STITCH_DB.DS_WORK.DS_DETECTION_INFERENCE where created_at > '2024-09-10' and category not in ('rc','insurance') 
and appointment in ('10159921795')
and category in ('lhsFenders') ; 