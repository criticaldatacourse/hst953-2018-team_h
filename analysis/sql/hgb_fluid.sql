select hgb.subject_id,  hgb.icustay_id, hgb.hadm_id, hgb.HEMOGLOBIN_1st, 
hgb.hemoglobin_24, hgb.hgb_difference, fluid.total_ns
from `hst-953-2018.team_h.hgb_differ` as hgb
left join `hst-953-2018.team_h.included_pt_with_ns` as fluid
on hgb.icustay_id = fluid.icustay_id
where total_ns is not null
