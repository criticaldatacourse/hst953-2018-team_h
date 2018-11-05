select subject_id,icustay_id from (
              with t1 as
              (
                select
                   co.icustay_id,
                   co.SUBJECT_ID,
                   DATETIME_DIFF(mv.endtime, co.intime, SECOND)/60.0/60.0 as hr,
                   round(case
                    when mv.amountuom = 'L'
                      then mv.amount * 1000.0
                    when mv.amountuom = 'ml'
                      then mv.amount
                  else null end) as amount
                from `physionet-data.mimiciii_clinical.icustays` co
                inner join `physionet-data.mimiciii_clinical.inputevents_mv` mv
                on co.icustay_id = mv.icustay_id
                where mv.statusdescription != 'Rewritten' and mv.itemid  in  (
                    222168, -- NaCl 0.9%
                    226364,
                    227210,
                    225943,
                    225168,
                    225168,
                    225953,
                    225943,
                    224145
                )
              )
              , t2 as
              (
                select
                 co.icustay_id,
                 co.subject_id,
                 DATETIME_DIFF(cv.charttime, co.intime, SECOND)/60.0/60.0 as hr,
                 round(cv.amount) as amount
                from `physionet-data.mimiciii_clinical.icustays` co
                inner join `physionet-data.mimiciii_clinical.inputevents_cv` cv
                on co.icustay_id = cv.icustay_id
                  where cv.amountuom = 'ml'
                  and cv.itemid in  (
                  30131,
                  30101,
                  43739,
                  30025,
                  30001,
                  3799,
                  30025

                )
              )
              select
                  icustay_id,
                  subject_id,
                  hr
                  from t1
              where hr <= 24
              -- just because the rate was high enough, does *not* mean the final amount was
              UNION ALL
              select
                  icustay_id,
                  subject_id,
                  hr
              from t2
              where hr <= 24
              group by t2.icustay_id, t2.subject_id, t2.hr
              ) 
    group by subject_id, icustay_id
