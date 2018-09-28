# Hemodilution Effect among patients with Fluid Resuscitation 
**Amita Ketkar** , **Mingyu lu**

### Introduction:

Decreased concentration of cells and solids in blood is called hemodilution[1]. Haemoglobin concentration can be a marker for haemodilution. Low Haemoglobin(Hb) concentration in blood can be either due to diseases such as anemia, liver cirrhosis, leukemia or conditions like sickle cell anemia, thalassemia, splenomegaly which cause the destruction of red blood cells. Blood loss( internal or external) will also reduce Hb concentration[2].It is commonly believed, fluid administration results in hemodilution in turn reducing Hb concentration. Fluid administration(resuscitation) is a very common procedure in hospital mainly directed at improving microcirculation and attain better oxygen delivery[3]. Several studies discuss about how to minimize hemodilution effect in cardiac surgery during cardiopulmonary bypass due to fluids[7]. There are few prediction models which calculate the hemodilution rate due to bypass surgery[8]. Furthermore,one study shows strong association between fluid resuscitation and hemoglobin concentration among patients in septic shock[9]. Another study found significant change in Hb, Hct, WBC, platelet, BUN, BE, HCO3, and PCO2 levels after saline infusion in trauma patients[10].  However, clear guidelines do not exist for determination of the extent of hemodilution acceptable after administration of fluid. If we can predict the expected amount of hemodilution after fluid administration before any surgical intervention; we can detect abnormal changes( eg. due to internal bleeding) early and provide better treatment to patients.

### Research Hypotheses:

We hypothesize that intravenous(IV) fluid administration results in hemodilution and there is a quantifiable dose-response relation between fluid resuscitation and hemoglobin concentration that can be used to estimate expected hemodilution among critically ill patients.  Definite conclusions regarding the expected hemodilution will allow us to identify the patients who need additional tests and interventions earlier.

### Research Question / Objective:

1. To identify and quantify the change in hemoglobin concentration after IV fluid resuscitation among critically ill patients using hospital registry data for patients admitted in ICU. 
2. To build a simplified predictive model of expected hemodilution after fluid resuscitation. 

### Methods

### Data Sources:

Our study will be built on hospital-based, open, prospective data collected in MIMIC-III (Medical Information Mart for Intensive Care III) database which has information of over forty thousand patients who stayed in critical care units of the Beth Israel Deaconess Medical Center between 2001 and 2012. The database includes information such as demographics, vital sign measurements made at the bedside (1 data point per hour), laboratory test results, procedures, medications, caregiver notes, imaging reports, and mortality (both in and out of hospital).[4,5]. We will use this data to build predictive models and cross validated. We will also use eICU database for validating our model in an independent dataset. eICU is large multicenter critical care database with information about more than 200,000 patients made available by Philips healthcare and MIT laboratory of computational physiology[5,6]. All the data in MIMIC-III and eICU does not contain any patient health information(PHI).


### Study Population and Exposure:

We will identify subjects admitted to intensive care units between 2001 to 2012; without the diagnosis of internal bleeding or bleeding disorders. Data obtained from first 24 hours after admission to ICU will be included. Only single admission to ICU in one hospitalisation will be considered; however, we will include data from every hospitalisation for the same subject. Main exposure of interest is intravenous 0.9% saline administration which will be ascertained from the information obtained from fluids in d_labitems in MIMIC III data. The volume of fluid, the concentration of NaCl, antibiotics/medicines given along with the saline are important factors to consider. If the patient is given medicines like vitamins or antibiotics through 0.9% saline vehicle, we will use a standard conversion rate to determine the volume of fluid.  We will include patients with comorbidities like chronic renal diseases, diabetes, congestive heart diseases etc. 
We will exclude subjects (a) patients who were administered fluids other than normal saline(0.9%) (b) in end-stage renal disease and were receiving hemodialysis treatment (c) subjects with thalassemia, lymphoma, leukemia (c) transfusion dependent patients (d) patients with any active bleeding, (e) patients who undergo any surgery in the timeline of interest. The information will be accessed through MIMIC III database ICD codes from diagnosis_icd chart.


### Study Outcomes:

To determine the hemodilution effect we will consider changes in hemoglobin concentration before and after fluid resuscitation. Information of haemoglobin levels will be obtained from d_labitems. A potential association between the change in Hgb concentration and the volume of fluid administered will be evaluated. Based on the data, we will try and form a better fitted predictive model for expected change in concentration of haemoglobin.


### Covariate(s) of Interest (Exposure):

Demographic characters like age, gender, ethnicity will be included with age as a continuous variable and gender and ethnicity as categorical variables. Basic information obtained by general examination of patients like weight, height, blood pressure will be included. We will collect data on medical comorbidities and medications taken prior to the hospitalisation by information from past medical history. Specifically we will look at diabetes, congestive heart disease, chronic renal diseases etc. Effect modification by gender and age, anemia and gender might be present and their interaction will be taken into account.


### Confounders:

There might be factors which will confound association of interest. People with septic shock and people with neurogenic shock may react differently to fluid administration and hemodilution might be different as well. We need to consider the diagnosis of shock with ICD-9 codes. Diseases caused by hydrostatic imbalance in body eg. liver disease, coronary heart disease, body temperature, time to blood draw after fluid administration are some other variables which will be considered for being confounders. We will assume the volume of blood draw is minimal and will not have large effect on hemodilution. We will also consider that error in the calculation of hemoglobin level is low and it has a tight confidence interval. 

### Limitations:

We do not have access to information for prior fluid resuscitation through our ICU data registry. This might confound effects. MIMIC data has the laboratory values from one central lab but eICU data has information from multiple labs. We will have to consider that during our validation. We have population which is likely to be aged, has more comorbidities and results may differ in different population. 


### Acknowledgements:

We are immensely grateful to Dr. Nikhil Shankar, Andre Silva and Dr. Leo A. Celi for their guidance and invaluable inputs to this proposal draft. 

### References:
[1]  Hemodilution. (n.d.). Retrieved from https://www.merriam-webster.com/dictionary/hemodilution <br />
[2] Low hemoglobin count Causes. (2018, April 07). Retrieved from https://www.mayoclinic.org/symptoms/low-hemoglobin/basics/causes/sym-20050760__<br />
[3] Perel, A. (2017). Iatrogenic hemodilution: A possible cause for avoidable blood transfusions? Critical Care,21(1). doi:10.1186/s13054-017-1872-1<br />
[4] Johnson AEW, Pollard TJ, Shen L, Lehman L, Feng M, Ghassemi M, Moody B, Szolovits P, Celi LA, Mark RG. MIMIC-III, a freely accessible critical care database. Scientific Data (2016). <br />
[5] Goldberger AL, Amaral LAN, Glass L, Hausdorff JM, Ivanov PCh, Mark RG, Mietus JE, Moody GB, Peng C-K, Stanley HE. PhysioBank, PhysioToolkit, and PhysioNet: Components of a New Research Resource for Complex Physiologic Signals. Circulation 101(23):e215-e220 [Circulation Electronic Pages; http://circ.ahajournals.org/content/101/23/e215.full]; 2000 (June 13).<br />
[6] Pollard, T. (n.d.). Getting Started. Retrieved from https://eicu-crd.mit.edu/<br />
[7]Preventive Strategies for Minimizing Hemodilution in the Cardiac Surgery Patient During Cardiopulmonary Bypass https://www.jcvaonline.com/article/S1053-0770(15)00747-8/fulltext<br />
[8] R., H., K., N., K., O., . . . Genta. (2018, June 04). Novel method for estimating the total blood volume: The importance of adjustment using the ideal body weight and age for the accurate prediction of haemodilution during cardiopulmonary bypass | Interactive CardioVascular and Thoracic Surgery | Oxford Academic. Retrieved from https://academic.oup.com/icvts/advance-article/doi/10.1093/icvts/ivy173/5033023<br />
[9]The relationship between the decrease in haemoglobin concentration and the volume of fluids administered during resuscitation from septic shock may not be so “weak” https://ccforum.biomedcentral.com/articles/10.1186/s13054-018-2118-6 <br />
[10]Paydar, S., Bazrafkan, H., Golestani, N., Roozbeh, J., Akrami, A., & Moradi, A. M. (2014). Retrieved from https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4614590/<br />
