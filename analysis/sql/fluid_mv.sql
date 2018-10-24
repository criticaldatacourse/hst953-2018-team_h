select distinct
    co.SUBJECT_ID
  from `physionet-data.mimiciii_clinical`.`icustays` co
  inner join `physionet-data.mimiciii_clinical`.`inputevents_mv` mv
  on co.icustay_id = mv.icustay_id
  where mv.statusdescription != 'Rewritten' and mv.itemid not in  (
      225158, -- NaCl 0.9%
      220954
  )
