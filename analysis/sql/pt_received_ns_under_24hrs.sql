with cv as( select icustay_id, subject_id, hadm_id, sum(amount) as total_ns_cv, min(starttime) as ns_given_time
from `hst-953-2018.team_h.ns_cv_v1` 
where hr <= 24 and amount >= 100
group by icustay_id, subject_id,hadm_id),
 mv as(select icustay_id, subject_id, hadm_id, sum(amount) as total_ns_mv, min(starttime) as ns_given_time
from `hst-953-2018.team_h.ns_mv_v1` 
where hr <=24 and amount >= 100
group by icustay_id, subject_id,hadm_id)
select * from cv
union all 
select * from mv 
