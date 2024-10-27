select ins.appointment_id,
        inspection_end_time::date as inspection_date,
        store_id_seller,

-- DOORS
        -- LHS REAR          
                case when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as door_lhs_rear_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as door_lhs_rear_cc_severity_scale_damaged,


                -- case when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:workDone:value::varchar
                --     when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:workDone:value::varchar  
                --     when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:workDone:value::varchar  
                --     when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:workDone:value::varchar  
                --             else null end as door_lhs_rear_cc_work_done,

                case when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as door_lhs_rear_cc_severity_scale_Dent,


                case when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsRear_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsRear:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as door_lhs_rear_cc_severity_scale_rust,

        -- LHS FRONT                          
                case when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as door_lhs_Front_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as door_lhs_Front_cc_severity_scale_damaged,


                -- case when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:workDone:value::varchar
                --     when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:workDone:value::varchar  
                --     when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:workDone:value::varchar  
                --     when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:workDone:value::varchar  
                --             else null end as door_lhs_Front_cc_work_done,

                case when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as door_lhs_Front_cc_severity_scale_Dent,


                case when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_lhsFront_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:lhsFront:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as door_lhs_Front_cc_severity_scale_rust,


        -- RHS REAR                        
                case when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as door_rhs_rear_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as door_rhs_rear_cc_severity_scale_damaged,


                -- case when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:workDone:value::varchar
                --     when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:workDone:value::varchar  
                --     when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:workDone:value::varchar  
                --     when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:workDone:value::varchar  
                --             else null end as door_rhs_rear_cc_work_done,

                case when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as door_rhs_rear_cc_severity_scale_Dent,


                case when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsRear_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsRear:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as door_rhs_rear_cc_severity_scale_rust,

        -- RHS FRONT                          
                case when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as door_rhs_Front_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as door_rhs_Front_cc_severity_scale_damaged,


                -- case when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:workDone:value::varchar
                --     when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:workDone:value::varchar  
                --     when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:workDone:value::varchar  
                --     when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_1') 
                --             then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:workDone:value::varchar  
                --             else null end as door_rhs_Front_cc_work_done,

                case when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as door_rhs_Front_cc_severity_scale_Dent,


                case when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_doors_rhsFront_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:doors:subParts:rhsFront:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as door_rhs_Front_cc_severity_scale_rust,

-- Fender
        -- LHS          
                case when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0') 
                            then inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as fender_lhs_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as fender_lhs_cc_severity_scale_damaged,

                case when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as fender_lhs_cc_severity_scale_Dent,

                case when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_lhs_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:fenders:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as fender_lhs_cc_severity_scale_rust,
        -- RHS                            
                case when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_0') 
                            then inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as fender_rhs_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_0') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as fender_rhs_cc_severity_scale_damaged,

                case when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_2') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as fender_rhs_cc_severity_scale_Dent,

                case when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_fenders_rhs_additionalInfo_form_3') 
                            then  inspection_data:exteriorTyres:fenders:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as fender_rhs_cc_severity_scale_rust,

-- Quarter Panels
        -- LHS   
                case when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_0')
                            then inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as Quarterpanel_lhs_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as Quarterpanel_lhs_cc_severity_scale_damaged,

                case when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as Quarterpanel_lhs_cc_severity_scale_Dent,

                case when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_quarterPanel_lhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as QuarterPanel_lhs_cc_severity_scale_rust,
        -- RHS 
                case when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_0')
                            then inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as Quarterpanel_rhs_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as Quarterpanel_rhs_cc_severity_scale_damaged,

                case when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as Quarterpanel_rhs_cc_severity_scale_Dent,

                case when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_quarterPanel_rhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:quarterPanel:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as Quarterpanel_rhs_cc_severity_scale_rust,

-- Running Border
        -- LHS   
                case when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_0')
                            then inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as runningBorder_lhs_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as runningBorder_lhs_cc_severity_scale_damaged,

                case when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as runningBorder_lhs_cc_severity_scale_Dent,

                case when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_runningBorder_lhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:lhs:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as runningBorder_lhs_cc_severity_scale_rust,

        -- RHS 
                case when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_0')
                            then inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Scratched::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Scratched::int
                            else null end as runningBorder_rhs_cc_severity_scale_scratched,

                case when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Damaged::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_0')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Damaged::int
                            else null end as runningBorder_rhs_cc_severity_scale_damaged,

                case when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Dented::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_2')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Dented::int
                            else null end as runningBorder_rhs_cc_severity_scale_Dent,

                case when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[0]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[0]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[1]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[1]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[2]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[2]:severityScaleCC:value:Rusted::int
                    when  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[3]:hashKey::varchar in ('exteriorTyres_runningBorder_rhs_additionalInfo_form_3')
                            then  inspection_data:exteriorTyres:runningBorder:subParts:rhs:additionalInfo[3]:severityScaleCC:value:Rusted::int
                            else null end as runningBorder_rhs_cc_severity_scale_rust,




from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" ins

where inspection_end_time::date >= (getdate()::date - 30)
and store_id_seller in (1985)
and inspection_status in ('done')
and version=0 ;

left join (
select inf.appointment_id as appointment_id_2 ,
response_data :or_flags.exteriorTyres.doors.subParts.lhsRear.flag AS lhsRear_flag,
response_data :or_flags.exteriorTyres.doors.subParts.lhsFront.flag AS lhsFront_flag,
response_data :or_flags.exteriorTyres.doors.subParts.rhsRear.flag AS rhsRear_flag,
response_data :or_flags.exteriorTyres.doors.subParts.rhsFront.flag AS rhsFront_flag,
from PC_STITCH_DB.MONGO_ATLAS_INSENGINEAPI_PROD.INS_LIKELIHOOD_DATA_LOG inf
where created_at::date >= (getdate()::date - 7)
and request_data :storeId::int in (1985,1961)
        )inf on ins.appointment_id=inf.appointment_id_2;



                select * from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG"
                where store_id_seller

;

select * from "PC_STITCH_DB"."MONGO_ATLAS_INSENGINEAPI_PROD"."INSPECTION_LOG" limit 10 