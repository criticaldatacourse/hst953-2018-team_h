---- The excluded ICD-9 code were as below

with t1 as( 
              select  subject_id,HADM_ID
              from  `physionet-data.mimiciii_clinical.diagnoses_icd`
              where ICD9_CODE in
              (select ICD9_CODE
              	from `physionet-data.mimiciii_clinical.d_icd_diagnoses`
                    		where ICD9_code  LIKE "578%" or
                        ICD9_code LIKE "5320%"or
                        ICD9_code LIKE '5322%'or 
                        ICD9_code LIKE'5324%'or
                        ICD9_code LIKE'5326%'or
                        ICD9_code LIKE '5310%'or
                        ICD9_code LIKE '5312%'or 
                        ICD9_code LIKE'5314%'or
                        ICD9_code LIKE '5316%'or
                        ICD9_code LIKE'5330%'or
                        ICD9_code LIKE '5332%'or
                        ICD9_code LIKE'5334%'or
                        ICD9_code LIKE '5336%'or 
                        ICD9_code LIKE '5340%'or
                        ICD9_code LIKE '5342%'or
                        ICD9_code LIKE '5344%'or
                        ICD9_code LIKE '5346%'or
                        ICD9_code LIKE  '5351%'or
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
              		)
              group by subject_id,HADM_ID
              )
select t1.subject_id, t1.hadm_id, icu.icustay_id from t1
              left join `physionet-data.mimiciii_clinical.icustays` as icu
              on t1.hadm_id = icu.hadm_id
              
