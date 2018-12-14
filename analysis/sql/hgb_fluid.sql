---- This script combines the total volume of normal saline and the difference of hemoglobin between measurements


select hgb.subject_id,  hgb.icustay_id, hgb.hadm_id, hgb.ICU_admitted, hgb.first_measurement, 
hgb.last_measurement,
hgb.HEMOGLOBIN_1st, 
hgb.hemoglobin_24, hgb.hgb_difference, fluid.total_ns_cv
from `hst-953-2018.team_h.hgb_differ` as hgb
left join `hst-953-2018.team_h.valid_pt_received_ns` as fluid
on hgb.icustay_id = fluid.icustay_id
where total_ns_cv is not null 
