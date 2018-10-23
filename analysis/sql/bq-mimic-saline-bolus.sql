with t1 as
(
  select
    co.icustay_id,    co.SUBJECT_ID
  , DATETIME_DIFF(mv.starttime, co.intime, SECOND)/60.0/60.0 as hr
  -- standardize the units to millilitres
  -- also metavision has floating point precision.. but we only care down to the mL
  , round(case
      when mv.amountuom = 'L'
        then mv.amount * 1000.0
      when mv.amountuom = 'ml'
        then mv.amount
    else null end) as amount
  from `physionet-data.mimiciii_clinical`.`icustays` co
  inner join `physionet-data.mimiciii_clinical`.`inputevents_mv` mv
  on co.icustay_id = mv.icustay_id
  and mv.itemid in
  (
      225158, -- NaCl 0.9%
      220954
  )
  where mv.statusdescription != 'Rewritten'
  and
  -- in MetaVision, these ITEMIDs appear with a null rate IFF endtime=starttime + 1 minute
  -- so it is sufficient to:
  --    (1) check the rate is > 240 if it exists or
  --    (2) ensure the rate is null and amount > 240 ml
    (
      (mv.rate is not null and mv.rateuom = 'mL/hour' and mv.rate > 10)
      OR (mv.rate is not null and mv.rateuom = 'mL/min' and mv.rate > (10/60.0))
      OR (mv.rate is null and mv.amountuom = 'L' and mv.amount > 0.01)
      OR (mv.rate is null and mv.amountuom = 'ml' and mv.amount > 10)
    )
)
, t2 as
(
  select
    co.icustay_id, co.subject_id
  , DATETIME_DIFF(cv.charttime, co.intime, SECOND)/60.0/60.0 as hr
  -- carevue always has units in millilitres
  , round(cv.amount) as amount
  from `physionet-data.mimiciii_clinical`.`icustays` co
  inner join `physionet-data.mimiciii_clinical`.`inputevents_cv` cv
  on co.icustay_id = cv.icustay_id
  and cv.itemid in
  (
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
  where cv.amount > 100
  and cv.amountuom = 'ml'
)
select
    icustay_id,
    subject_id,
    hr
  , sum(amount) as crystalloid_bolus
from t1
-- just because the rate was high enough, does *not* mean the final amount was
where amount >= 100 and hr <= 24
group by t1.icustay_id, t1.hr, t1.subject_id
UNION ALL
select
    icustay_id,
    subject_id
  , hr
  , sum(amount) as crystalloid_bolus
from t2
where subject_id in (select  SUBJECT_ID
from  `physionet-data.mimiciii_clinical`.`diagnoses_icd`
 where
ICD9_CODE in
(select ICD9_CODE
	from `physionet-data.mimiciii_clinical`.`d_icd_diagnoses`
     where ROW_ID not in(
	select ROW_ID
	from `physionet-data.mimiciii_clinical`.`d_icd_diagnoses`
		where ICD9_code  LIKE "578%" or
		ICD9_code LIKE "53%" or
		ICD9_CODE LIKE "7863%" or
		lower(LONG_TITLE) Like "%hemoptysis%"or
		ICD9_CODE LIKE "456%" or
		ICD9_CODE LIKE "303%" or
		ICD9_CODE LIKE "571%" or
		ICD9_CODE LIKE "E81%" or
		ICD9_CODE LIKE "865%"or
		ICD9_CODE LIKE "864%" or
		ICD9_CODE LIKE "866%" or
		ICD9_CODE LIKE "860%" or
		ICD9_CODE LIKE "633%" or
		ICD9_CODE LIKE "626%"or
		ICD9_CODE LIKE "632%" or
		ICD9_CODE LIKE "634%" or
		ICD9_CODE LIKE "635%" or
		ICD9_CODE LIKE "636%" or
		ICD9_CODE LIKE "637%" or
		ICD9_CODE LIKE "638%" or
		ICD9_CODE LIKE "639%" or
		ICD9_CODE LIKE "7847%" or
		ICD9_CODE LIKE "20%" or
		ICD9_Code LIKE "285%" or
		ICD9_CODE LIKE "5855%" or
		ICD9_CODE LIKE "5856%" or
		ICD9_CODE LIKE "V56%" or
		ICD9_CODE LIKE "V4511%"
		))
group by SUBJECT_ID

)
group by t2.icustay_id, t2.hr,t2.subject_id
order by icustay_id, hr;
