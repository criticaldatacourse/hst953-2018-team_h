select * from `hst-953-2018.team_h.pt_receive_ns_within24_18_80` 
where hadm_id not in (
select hadm_id from `hst-953-2018.team_h.excluded_icd9_pts` 
union all 
select hadm_id from `hst-953-2018.team_h.pt_reveice_excluded_fluid`
where hadm_id is not null
group by hadm_id
)
