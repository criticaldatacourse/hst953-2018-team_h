with t1 as
(
  select
    co.icustay_id,    co.SUBJECT_ID
  , DATETIME_DIFF(mv.starttime, co.intime, SECOND)/60.0/60.0 as hr
  from `physionet-data.mimiciii_clinical`.`icustays` co
  inner join `physionet-data.mimiciii_clinical`.`inputevents_mv` mv
  on co.icustay_id = mv.icustay_id
  where mv.statusdescription != 'Rewritten' and mv.itemid not in  (
      225158, -- NaCl 0.9%
      220954
  )
)
, t2 as
(
  select
    co.icustay_id, co.subject_id
  , DATETIME_DIFF(cv.charttime, co.intime, SECOND)/60.0/60.0 as hr
  from `physionet-data.mimiciii_clinical`.`icustays` co
  inner join `physionet-data.mimiciii_clinical`.`inputevents_cv` cv
  on co.icustay_id = cv.icustay_id
  where cv.itemid not in  (
    30352,
    30018,
    44440,
    44053,
    30190,
    41913,
    40865,
    42548,
    41695,
    41490,
    42844,
    44491,
    45137,
    46314,
    45989,
    42749,
    41467,
    44983,
    44741
  )
)
select
    icustay_id,
    subject_id,
    hr
from t1
-- just because the rate was high enough, does *not* mean the final amount was
where  hr <= 24
group by t1.icustay_id, t1.hr, t1.subject_id
UNION ALL
select
    icustay_id,
    subject_id
  , hr
from t2
group by t2.icustay_id, t2.hr,t2.subject_id
order by icustay_id, hr;