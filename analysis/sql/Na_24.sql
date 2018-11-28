WITH pvt AS (
  SELECT ie.subject_id, ie.hadm_id, ie.icustay_id, le.charttime,ie.intime,
  DATETIME_DIFF(le.charttime, ie.intime, SECOND)/60.0/60.0 as hr
  -- here we assign labels to ITEMIDs
  -- this also fuses together multiple ITEMIDs containing the same data
  , CASE
        when itemid = 50983 then 'Na'
      ELSE null
      END AS label
  , -- add in some sanity checks on the values
    -- the where clause below requires all valuenum to be > 0, 
    -- so these are only upper limit checks
    CASE
      when le.itemid = 50983 and le.valuenum >    200 then null 
    ELSE le.valuenum
    END AS valuenum
  FROM `physionet-data.mimiciii_clinical.icustays` ie
  LEFT JOIN `physionet-data.mimiciii_clinical.labevents` le
    ON le.subject_id = ie.subject_id 
    AND le.hadm_id = ie.hadm_id
    AND le.itemid IN
    (
      50983
    )
    AND le.valuenum IS NOT null 
    AND le.valuenum > 0 -- lab values cannot be 0 and cannot be negative
    
    LEFT JOIN `physionet-data.mimiciii_clinical.admissions` ad
    ON ie.subject_id = ad.subject_id
    AND ie.hadm_id = ad.hadm_id
    
    -- WHERE ie.subject_id < 10000
    
),
ranked AS (
SELECT pvt.*, DENSE_RANK() OVER (PARTITION BY 
    pvt.subject_id, pvt.hadm_id,pvt.icustay_id,pvt.label ORDER BY pvt.charttime desc) as drank
FROM pvt
left join `hst-953-2018.team_h.valid_pt_received_ns` as h 
on h.hadm_id = pvt.hadm_id and h.subject_id = pvt.subject_id
where pvt.hr <= 24 and pvt.hadm_id in 
(select hadm_id from `hst-953-2018.team_h.valid_pt_received_ns`) and pvt.charttime > h.ns_given_time
) 
SELECT r.subject_id, r.hadm_id, r.icustay_id,min(r.intime) as admission_time, max(r.charttime) as last_measurement
  , max(case when label = 'Na' then valuenum else null end) as Na_24
FROM ranked r
left join `hst-953-2018.team_h.valid_pt_received_ns` h
on h.hadm_id = r.hadm_id
WHERE r.drank = 1 
GROUP BY r.subject_id, r.hadm_id, r.icustay_id, r.drank
ORDER BY r.subject_id, r.hadm_id, r.icustay_id, r.drank;
