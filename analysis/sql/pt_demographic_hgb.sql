WITH patientAge AS(
SELECT ad.hadm_id, ad.subject_id, (DATETIME_DIFF(ad.admittime,p.dob, year)) 
            AS age
      FROM `physionet-data.mimiciii_clinical.admissions` as ad
      INNER JOIN `physionet-data.mimiciii_clinical.patients` as p
      ON ad.subject_id = p.subject_id
      WHERE ad.admittime IS NOT NULL
    )
select ad.ethnicity, ad.diagnosis, patientAge.age ,hgb.subject_id,  hgb.icustay_id, hgb.hadm_id, hgb.ICU_admitted, hgb.first_measurement, 
hgb.last_measurement,
hgb.HEMOGLOBIN_1st, 
hgb.hemoglobin_24,DATETIME_DIFF(hgb.last_measurement, hgb.first_measurement, SECOND)/60.0/60.0 as hr, hgb.hgb_difference, fluid.total_ns_cv
from `hst-953-2018.team_h.hgb_differ` as hgb
left join `hst-953-2018.team_h.valid_pt_received_ns` as fluid
on hgb.icustay_id = fluid.icustay_id
left join patientAge 
on hgb.HADM_ID =  patientAge.hadm_id
left join `physionet-data.mimiciii_clinical.admissions` as ad
on ad.hadm_id = hgb.hadm_id
where total_ns_cv is not null and patientAge.age <= 80
