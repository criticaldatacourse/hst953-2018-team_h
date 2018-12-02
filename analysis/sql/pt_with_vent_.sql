select f.ethnicity, f.diagnosis, f.age, f.weight_first, f.subject_id, 
f.icustay_id, f.hadm_id, f.ICU_admitted, f.first_measurement, f.last_measurement,
f.HEMOGLOBIN_1st, f.hemoglobin_24, max(c.creatinine) as cre_1st, f.hr, f.hgb_difference, f.total_ns_cv,
f.total_urine as uo_1hr, max(uo6.total_urine_6) as uo_6hr,
max(v.MechVent), max(v.OxygenTherapy), max(v.Extubated), max(v.SelfExtubated)
from `hst-953-2018.team_h.final_table` as f
left join `hst-953-2018.team_h.cre_1st` as c
on f.icustay_id = c.icustay_id
left join `hst-953-2018.team_h.urineoutput_6hr` as uo6
on uo6.icustay_id = f.icustay_id
left join `hst-953-2018.team_h.ventsettings_v1`  as v
on v.icustay_id = f.icustay_id
where datetime_diff(v.charttime,f.ICU_admitted, second)/60/60 <=1 
and datetime_diff(v.charttime,f.ICU_admitted, second)/60/60 >= -1 
group by f.icustay_id,f.ethnicity, f.diagnosis, f.age, f.weight_first, 
f.subject_id,f.hadm_id,f.ICU_admitted, f.first_measurement, f.last_measurement,
f.HEMOGLOBIN_1st, f.hemoglobin_24, f.hr, f.hgb_difference, f.total_ns_cv, f.total_urine, f.rate
