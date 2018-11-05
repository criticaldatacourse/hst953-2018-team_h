with cv as( select icustay_id, subject_id, sum(amount) as total_ns_cv
from `hst-953-2018.team_h.cv_ns` 
where hr <24 and amount >= 100
group by icustay_id, subject_id),
 mv as(select icustay_id, subject_id, sum(amount) as total_ns_mv
from `hst-953-2018.team_h.mv_ns` 
where hr <24 and amount >= 100
group by icustay_id, subject_id)
select * from cv
union all 
select * from mv 
