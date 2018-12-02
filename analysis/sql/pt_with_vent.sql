select f.ethnicity, f.diagnosis, f.age, f.weight_first, f.subject_id, 
f.icustay_id, f.hadm_id, f.ICU_admitted, f.first_measurement, f.last_measurement,
f.HEMOGLOBIN_1st, f.hemoglobin_24, f.hr, f.hgb_difference, f.total_ns_cv, f.total_urine, f.rate
, v.MechVent, v.OxygenTherapy, v.Extubated, v.SelfExtubated
from `hst-953-2018.team_h.final_table` as f
left join `hst-953-2018.team_h.ventsettings_v1` as v
on v.icustay_id = f.icustay_id
where DATETIME_DIFF(v.charttime, f.ICU_admitted, SECOND)/60.0/60.0 <= 24
and  DATETIME_DIFF(v.charttime, f.ICU_admitted, SECOND)/60.0/60.0 >= -1
group by f.icustay_id,f.ethnicity, f.diagnosis, f.age, f.weight_first, 
f.subject_id,f.hadm_id,f.ICU_admitted, f.first_measurement, f.last_measurement,
f.HEMOGLOBIN_1st, f.hemoglobin_24, f.hr, f.hgb_difference, f.total_ns_cv, f.total_urine, f.rate
, v.MechVent, v.OxygenTherapy, v.Extubated, v.SelfExtubated
