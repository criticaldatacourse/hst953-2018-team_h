with t1 as (
select f.ethnicity, f.diagnosis, f.age, f.weight_first, f.subject_id, 
f.icustay_id, f.hadm_id, f.ICU_admitted, f.first_measurement, f.last_measurement,
f.HEMOGLOBIN_1st, f.hemoglobin_24, f.cre_1st, f.hr, f.hgb_difference, f.total_ns_cv,
f.uo_1hr, f.uo_6hr,
case when (MechVent) is null then 0 else (MechVent) end as MechVent,
case when  (OxygenTherapy) is null then 0 else OxygenTherapy end as OxygenTherapy, 
case when (Extubated) is null then 0 else (Extubated) end as Extubated,
case when (SelfExtubated) is null then 0 else (SelfExtubated) end as SelfExtubated,
case when (hour >= 24 or hour < -6) then null else hour end as hour
from `hst-953-2018.team_h.pt_vent_v2` as f
group by f.icustay_id,f.ethnicity, f.diagnosis, f.age, f.weight_first, f.cre_1st,
f.subject_id,f.hadm_id,f.ICU_admitted, f.first_measurement, f.last_measurement,
f.HEMOGLOBIN_1st, f.hemoglobin_24, f.hr, f.hgb_difference, f.total_ns_cv, f.uo_1hr,f.uo_6hr, 
(MechVent), (OxygenTherapy), (Extubated), (SelfExtubated), hour )

select f.ethnicity, f.diagnosis, f.age, f.weight_first, f.subject_id, 
f.icustay_id, f.hadm_id, f.ICU_admitted, f.first_measurement, f.last_measurement,
f.HEMOGLOBIN_1st, f.hemoglobin_24, f.cre_1st, f.hr, f.hgb_difference, f.total_ns_cv,
max(MechVent), max(OxygenTherapy), max(Extubated), max(SelfExtubated),
f.uo_1hr, f.uo_6hr from t1 as f
where 
(hour >= -6 and hour <=24 )
or hour is null 
group by f.icustay_id,f.ethnicity, f.diagnosis, f.age, f.weight_first, f.cre_1st,
f.subject_id,f.hadm_id,f.ICU_admitted, f.first_measurement, f.last_measurement,
f.HEMOGLOBIN_1st, f.hemoglobin_24, f.hr, f.hgb_difference, f.total_ns_cv, f.uo_1hr,f.uo_6hr
