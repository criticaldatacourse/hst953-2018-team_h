select hgb.subject_id,  hgb.icustay_id, hgb.hadm_id, hgb.ICU_admitted, hgb.first_measurement, 
hgb.last_measurement,
hgb.hct_1st, 
hgb.hct_24, hgb.hct_difference, fluid.total_ns_cv
from `hst-953-2018.team_h.hct_differ` as hgb
left join `hst-953-2018.team_h.valid_pt_received_ns` as fluid
on hgb.icustay_id = fluid.icustay_id
where total_ns_cv is not null 
