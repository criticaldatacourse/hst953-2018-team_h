select* from `hst-953-2018.team_h.pt_receive_ns_under24hrs` 
where icustay_id not in (
select icustay_id from `hst-953-2018.team_h.pt_reveice_excluded_fluid` 
union all 
select icustay_id from `hst-953-2018.team_h.excluded_icd9_pt_id` 
where icustay_id is not null
group by icustay_id
) and subject_id in (select subject_id from `hst-953-2018.team_h.ptid_under_80` )
