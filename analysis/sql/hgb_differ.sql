select n.subject_id, n.hadm_id, n.icustay_id,h.admission_time as ICU_admitted, n.first_measurement, h.last_measurement,
n.HEMOGLOBIN_1st, 
h.HEMOGLOBIN_24,
round(  h.HEMOGLOBIN_24- n.HEMOGLOBIN_1st ,4) as hgb_difference
from `hst-953-2018.team_h.hgb_1` as n
left join `hst-953-2018.team_h.hgb_24` as h
on n.icustay_id = h.icustay_id
where n.HEMOGLOBIN_1st is not null and h.HEMOGLOBIN_24 is not null
order by subject_id 
