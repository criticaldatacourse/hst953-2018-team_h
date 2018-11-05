WITH patientAge AS(
SELECT ad.subject_id, (DATETIME_DIFF(ad.admittime,p.dob, year)) 
            AS age
      FROM `physionet-data.mimiciii_clinical.admissions` as ad
      INNER JOIN `physionet-data.mimiciii_clinical.patients` as p
      ON ad.subject_id = p.subject_id
      WHERE ad.admittime IS NOT NULL
    )
    SELECT * from patientAge where age >= 18 and age <= 80
