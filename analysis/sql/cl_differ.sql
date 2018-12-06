select n.subject_id, n.hadm_id, n.icustay_id,h.admission_time as ICU_admitted, n.first_measurement, h.last_measurement,
n.cl_1st, 
h.cl_24,
round(  h.cl_24- n.cl_1st ,4) as Na_difference
from `hst-953-2018.team_h.cl_1st` as n
left join `hst-953-2018.team_h.cl_24` as h
on n.icustay_id = h.icustay_id and h.hadm_id = n.hadm_id 
where n.cl_1st is not null and h.cl_24 is not null and first_measurement != last_measurement
order by subject_id 
