select n.subject_id, n.hadm_id, n.icustay_id,h.admission_time as ICU_admitted, n.first_measurement, h.last_measurement,
n.HCO3_1st, 
h.HCO3_24,
round(  h.HCO3_24- n.HCO3_1st ,4) as hco3_difference
from `hst-953-2018.team_h.hco3_1st` as n
left join `hst-953-2018.team_h.hco3_24` as h
on n.icustay_id = h.icustay_id and h.hadm_id = n.hadm_id 
where n.HCO3_1st is not null and h.HCO3_24 is not null and first_measurement != last_measurement
order by subject_id 
