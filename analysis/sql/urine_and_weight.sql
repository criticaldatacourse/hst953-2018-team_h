---- It extracts the urine output and the weight of patients 

select oe.icustay_id, min(oe.charttime) as charttime, oe.hadm_id, icu.intime, 
max(DATETIME_DIFF(oe.charttime, icu.intime, SECOND)/60.0/60.0)
as hr, SUM(
-- we consider input of GU irrigant as a negative volume
case when oe.itemid = 227488 then -1*oe.value
else oe.value end
) as total_urine, SUM(
-- we consider input of GU irrigant as a negative volume
case when oe.itemid = 227488 then -1*oe.value
else oe.value end
)/max(DATETIME_DIFF(oe.charttime, icu.intime, SECOND)/60.0/60.0)
 as rate , AVG(CAST(w.value as FLOAT64)) as weight, (SUM(
-- we consider input of GU irrigant as a negative volume
case when oe.itemid = 227488 then -1*oe.value
else oe.value end
)/max(DATETIME_DIFF(oe.charttime, icu.intime, SECOND)/60.0/60.0))/AVG(CAST(w.value as FLOAT64))  as rate_over_weight
from `physionet-data.mimiciii_clinical.outputevents` oe
left join `physionet-data.mimiciii_clinical.icustays` as icu
on icu.hadm_id = oe.hadm_id
left join `physionet-data.mimiciii_clinical.chartevents`as w
on w.hadm_id = oe.hadm_id 
where oe.iserror IS NULL
  and oe.itemid in
(
  -- these are the most frequently occurring urine output observations in CareVue
  40055, -- "Urine Out Foley"
  43175, -- "Urine ."
  40069, -- "Urine Out Void"
  40094, -- "Urine Out Condom Cath"
  40715, -- "Urine Out Suprapubic"
  40473, -- "Urine Out IleoConduit"
  40085, -- "Urine Out Incontinent"
  40057, -- "Urine Out Rt Nephrostomy"
  40056, -- "Urine Out Lt Nephrostomy"
  40405, -- "Urine Out Other"
  40428, -- "Urine Out Straight Cath"
  40086, --	"Urine Out Incontinent"
  40096, -- "Urine Out Ureteral Stent #1"
  40651, -- "Urine Out Ureteral Stent #2"
  
  -- these are the most frequently occurring urine output observations in MetaVision
  226559, -- "Foley"
  226560, -- "Void"
  226561, -- "Condom Cath"
  226584, -- "Ileoconduit"
  226563, -- "Suprapubic"
  226564, -- "R Nephrostomy"
  226565, -- "L Nephrostomy"
  226567, --	Straight Cath
  226557, -- R Ureteral Stent
  226558, -- L Ureteral Stent
  227488, -- GU Irrigant Volume In
  227489  -- GU Irrigant/Urine Volume Out
)
and oe.value < 5000 -- sanity check on urine value
and oe.icustay_id is not null
and DATETIME_DIFF(oe.charttime, icu.intime, SECOND)/60.0/60.0 <= 1
and DATETIME_DIFF(oe.charttime, icu.intime, SECOND)/60.0/60.0 > 0 
and w.itemid in
  (3693, 226512)
group by icustay_id, hadm_id,icu.intime
order by icustay_id, hadm_id;
