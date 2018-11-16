select n.subject_id, n.hadm_id, n.icustay_id, n.HEMOGLOBIN_1st, h.HEMOGLOBIN_24, n.first_measurement, h.last_measurement,
round(  h.HEMOGLOBIN_24- n.HEMOGLOBIN_1st ,4) as hgb_difference
from `hst-953-2018.team_h.hgb_first` as n
left join `hst-953-2018.team_h.hgb_after_24` as h
on n.icustay_id = h.icustay_id
where n.HEMOGLOBIN_1st is not null and h.HEMOGLOBIN_24 is not null
order by subject_id 
