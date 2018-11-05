 select
    co.icustay_id, co.subject_id, mv.starttime as starttime
  , DATETIME_DIFF(mv.endtime, co.intime, SECOND)/60.0/60.0 as hr
  -- standardize the units to millilitres
  -- also metavision has floating point precision.. but we only care down to the mL
  , round(case
      when mv.amountuom = 'L'
        then mv.amount * 1000.0
      when mv.amountuom = 'ml'
        then mv.amount
    else null end) as amount
  from `physionet-data.mimiciii_clinical.icustays` co
  inner join `physionet-data.mimiciii_clinical.inputevents_mv` mv
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
