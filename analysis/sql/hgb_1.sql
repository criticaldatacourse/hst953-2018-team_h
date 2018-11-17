WITH pvt AS (
  SELECT ie.subject_id, ie.hadm_id, ie.icustay_id, le.charttime,
  DATETIME_DIFF(le.charttime, ie.intime, SECOND)/60.0/60.0 as hr
  -- here we assign labels to ITEMIDs
  -- this also fuses together multiple ITEMIDs containing the same data
  , CASE
        when itemid = 50811 then 'HEMOGLOBIN'
        when itemid = 51222 then 'HEMOGLOBIN'
        when itemid = 50855 then 'HEMOGLOBIN'

      ELSE null
      END AS label
  , -- add in some sanity checks on the values
    -- the where clause below requires all valuenum to be > 0, 
    -- so these are only upper limit checks
    CASE
      when le.itemid = 50811 and le.valuenum >    50 then null -- g/dL 'HEMOGLOBIN'
      when le.itemid = 51222 and le.valuenum >    50 then null -- g/dL 'HEMOGLOBIN'
      when le.itemid = 50855 and le.valuenum >    50 then null -- g/dL 'HEMOGLOBIN'

    ELSE le.valuenum
    END AS valuenum
  FROM `physionet-data.mimiciii_clinical.icustays` ie
  LEFT JOIN `physionet-data.mimiciii_clinical.labevents` le
    ON le.subject_id = ie.subject_id 
    AND le.hadm_id = ie.hadm_id
    AND le.itemid IN
    (
      51222, -- HEMOGLOBIN | HEMATOLOGY | BLOOD | 752523
      50811, -- HEMOGLOBIN | BLOOD GAS | BLOOD | 89712
      50855
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
    pvt.subject_id, pvt.hadm_id,pvt.icustay_id,pvt.label ORDER BY pvt.charttime) as drank
FROM pvt
where  pvt.hadm_id in (select hadm_id from `hst-953-2018.team_h.valid_pt_received_ns`)
)
SELECT r.subject_id, r.hadm_id, r.icustay_id, min(r.charttime) as first_measurement
  , max(case when label = 'HEMOGLOBIN' then valuenum else null end) as HEMOGLOBIN_1st
FROM ranked r
left join `hst-953-2018.team_h.pt_receive_ns_within24_18_80` h
on h.subject_id = r.subject_id
WHERE r.drank = 1 and h.ns_given_time > r.charttime 
GROUP BY r.subject_id, r.hadm_id, r.icustay_id, r.drank
ORDER BY r.subject_id, r.hadm_id, r.icustay_id, r.drank;
