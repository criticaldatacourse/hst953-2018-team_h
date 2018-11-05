 select
    co.icustay_id, co.subject_id, cv.charttime as starttime
  , (DATETIME_DIFF(cv.charttime, co.intime, SECOND)/60.0/60.0 + (amount/ORIGINALRATE)) as hr
  -- carevue always has units in millilitres
  , round(cv.amount) as amount
  from `physionet-data.mimiciii_clinical.icustays` co
  inner join `physionet-data.mimiciii_clinical.inputevents_cv` cv
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
  where cv.amount > 100 and ORIGINALRATE > 0
  and cv.amountuom = 'ml'
