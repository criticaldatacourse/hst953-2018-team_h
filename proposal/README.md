# Hemodilution Effect among patients with Fluid Resuscitation 
**Amita Ketkar** , **Mingyu lu**

### Introduction:

Hemoglobin is a globular protein in the blood which carries oxygen. It is contained in Red Blood Cells (RBCs). Anemia is defined as a reduction in the hemoglobin level in the blood. Major causes of anemia are 1) acute blood loss by internal or external bleeding, 2) deficient RBC production like in leukemia 3) Increased RBC destruction or abnormality like in splenomegaly or sickle cell anemia [1]. It is commonly believed that fluid administration results in hemodilution in turn reducing Hgb concentration. Decreased concentration of hemoglobin in intravascular plasma volume due to IV fluid infusion is called hemodilution [2]. Fluid administration (resuscitation) is a very common procedure in the hospital, directed mainly at improving microcirculation to attain better oxygen delivery [3]. 

The concept of hemodilution is largely unexplored in humans. Several animal studies show that fluid administration as a treatment for hemorrhage results in physiological hemodilution [4,5,6,7]. In human studies, the focus on the effect is largely on cardiac bypass; the hemodilution effect has been observed in cardiac surgery during cardiopulmonary bypass due to fluids [8] and others have attempted to create prediction models that calculate the hemodilution rate due to bypass surgery [9]. Furthermore, one study shows a strong association between fluid resuscitation and hemoglobin concentration among patients in septic shock[10].

One prospective study of 84 patients in Shiraz, Iran found that changes in clinical or biochemical parameters like hemoglobin, WBC, platelet count, HCO3, PCO2 were statistically significant after 1 liter of saline administration in patients with minor trauma [11]. Another recent study considered volunteer blood donation a proxy for acute hemorrhage and quantified hemodilution after crystalloid fluid administration and built a prediction model for change in hemoglobin concentration. However, blood donation as a proxy is limited. The amount of trauma by donation is not completely comparable to actual trauma, as the former excludes inflammatory release, systematic response by the body, continuous losses of blood, and input of fluids. Furthermore, blood donors are inherently a healthier, younger population and the predicted association is assumed linear in nature [12].

Clear guidelines do not exist for determination of the expected amount of hemodilution after administration of fluid. If we can better predict the expected amount of hemodilution after fluid administration before any surgical intervention; we can detect abnormal changes (eg. due to internal bleeding) early and provide better treatment to patients.


### Research Hypotheses:

We hypothesize that intravenous (IV) fluid administration results in hemodilution and there is a quantifiable dose-response relation between fluid resuscitation and hemoglobin concentration that can be used to estimate expected hemodilution among critically ill patients.  Early diagnosis, interventions and treatment can be facilitated by flagging unexpected hemodilution in critically ill patients using predictive models.

### Research Question / Objective:

 * To identify and quantify the change in hemoglobin concentration after IV fluid resuscitation among critically ill patients using hospital registry data for patients admitted in ICU. 
 * To build a mathematical predictive model of expected hemodilution after fluid resuscitation. 

### Methods

### Data Sources:

Our study will be built on hospital-based, open, prospective data collected in the MIMIC-III (Medical Information Mart for Intensive Care III) database which has information of over forty thousand patients who stayed in critical care units of the Beth Israel Deaconess Medical Center between 2001 and 2012. The database includes information such as demographics, vital sign measurements made at the bedside (1 data point per hour), laboratory test results, procedures, medications, caregiver notes, imaging reports, and mortality (both in and out of hospital) [13,14]. We will use this data to build predictive models and for cross-validation. We will also use the eICU database for validating our model in an independent dataset. eICU is large multicenter critical care database with information on more than 200,000 patients made available by Philips healthcare and MIT Laboratory of Computational Physiology [14,15]. All the data in MIMIC-III and eICU does not contain any patient protected health information(PHI).


### Study Population and Exposure:

We will identify subjects admitted to intensive care units between 2001 to 2012 without the diagnosis of internal or external bleeding or bleeding disorders. We will include data from the first ICU admission during a patient’s hospitalization and focus on the first 24 hours of this first ICU admission. For patients with multiple ICU stays, only the first ICU admission per hospitalization will be considered. The main exposure of interest is 0.9 % saline which will be obtained from inputevents_cv or inputevents_mv,  tables of MIMIC III database which record events that occurred during the patient ICU stay related to the fluid input to patients. Therefore, we will exclude subjects who received other fluids such as dextrose-containing fluids or Lactated Ringer’s. The volume of fluid and antibiotics/medications given along with the saline are important factors to consider. If the patient is given medications like vitamins or antibiotics through 0.9% saline vehicle, we will use the standard conversion rates on Sigma Pump documentation, provided by hospital pharmacy, to determine the corresponding volume of fluid. 
Inclusion criteria of subjects are defined as below
 * Age between 18 - 64
 * Received NS within 24 hrs after admission 
 * Received Hgb or Hct draw at least twice per day
We will exclude subjects who are under the diagnoses of the following conditions. The information will be accessed through diagnosis_icd table of MIMIC-III database. 
 * Administered fluids other than 0.9 % normal saline within 24 hr after admission
 * Hemorrhage, active bleeding or any sign of internal or external bleeding
 * History of recent major trauma
 * Post-surgery, or undergoing any surgical treatment within 24 hr after admission
 * End-stage renal disease or receiving hemodialysis or peritoneal dialysis
 * Thalassemia 
 * Lymphoma
 * Leukemia
 * Chronic anemia 
 * Transfusion-dependent at baseline
 * Alcoholism
 * Liver cirrhosis 


### Study Outcomes:

To determine the hemodilution effect we will consider changes in hemoglobin concentration before and after fluid resuscitation. Information on Hgb levels is obtained from labevents in MIMIC-III database. A potential association between the change in Hgb concentration and the volume of fluid administered will be evaluated. Based on the data, we will try to form a better fitted predictive model for expected change in concentration of hemoglobin.


### Covariate(s) of Interest (Exposure):

Demographic characters like age, gender, ethnicity will be included with age as a continuous variable and gender and ethnicity as categorical variables. Basic information obtained by general examinations of patients such as weight, height will be included. We will collect data on medical comorbidities and medications taken prior to the hospitalization by information from past medical history. Specifically, we will look at diabetes, congestive heart disease, chronic renal diseases and other such comorbidities.


### Confounders:

For building a prediction model, we will try and incorporate confounders. The following factors will be considered.
 * Diseases causing a hydrostatic imbalance in the body or varied vascular permeability such as liver disease, congestive heart failure disease, and hypo or hyperthermia 
 * The time to blood draw after fluid administration 
 * Evidence of the usage of vasopressor as a proxy for shock
 * Amount of blood loss due to blood draws will be assumed negligible.
 * Output events will be given consideration


### Limitations:
We do not have access to information for prior fluid resuscitation through our ICU data registry i.e. fluid administered pre-hospital or in the Emergency Department. This might give rise to bias. We will have to consider that during our validation. We assume that blood draws will have a negligible effect on hemodilution, which may be a further limitation. The measured lab value of hemoglobin on lab assay may have an inherent error which may not be detected. The ICU population is inherently aged and has more comorbidities which might lead to issues in generalizability of prediction and effect size in critically ill patients and non critically ill patients. 

### Acknowledgements:

We are immensely grateful to Dr. Nikhil Shankar, Andre Silva and Dr. Leo A. Celi for their guidance and invaluable inputs to this proposal draft. 

### References:
[1] Schmaier, A. H., & Lazarus, H. M. (2012). Concise guide to hematology. Chichester, West Sussex, UK: Wiley-Blackwell. </br>
[2]  Hemodilution. (n.d.). Retrieved from https://www.merriam-webster.com/dictionary/hemodilution</br>
[3] Perel, A. (2017). Iatrogenic hemodilution: A possible cause for avoidable blood transfusions? Critical Care,21(1). doi:10.1186/s13054-017-1872-1</br>
[4]Cervera, A. L., & Moss, G. (1974). Crystalloid Distribution Following Hemorrhage And Hemodilution. The Journal of Trauma: Injury, Infection, and Critical Care,14(6), 506-520. doi:10.1097/00005373-197406000-00007</br>
[5]Wadström, J., & Gerdin, B. (1990). Effect of Bleeding and Hypervolaemic Haemodilution on Traumatic Vasospasm in Rabbits. Scandinavian Journal of Plastic and Reconstructive Surgery and Hand Surgery,24(2), 107-111. doi:10.3109/02844319009004529</br>
[6]Hannon, J., Wade, C., Bossone, C., Hunt, M., Coppes, R., & Loveday, J. (1990). Blood gas and acid-base status of conscious pigs subjected to fixed-volume hemorrhage and resuscitated with hypertonic saline dextran. Resuscitation,20(3), 265-266. doi:10.1016/0300-9572(90)90015-7</br>
[7]Kowalenko, T., Stern, S., Wang, X., Dronen, S., & Hurst, J. M. (1991). Improved Outcome With “Hypotensive” Resuscitation Of Uncontrolled Hemorrhagic Shock In A Swine Model. The Journal of Trauma: Injury, Infection, and Critical Care,31(7), 1032. doi:10.1097/00005373-199107000-00068</br>
[8]Hwang, N. C. (2015). Preventive Strategies for Minimizing Hemodilution in the Cardiac Surgery Patient During Cardiopulmonary Bypass. Journal of Cardiothoracic and Vascular Anesthesia,29(6), 1663-1671. doi:10.1053/j.jvca.2015.08.002</br>
[9] Muraki, R., Hiraoka, A., Nagata, K., Nakajima, K., Oshita, T., Arimichi, M., . . . Sakaguchi, T. (2018). Novel method for estimating the total blood volume: The importance of adjustment using the ideal body weight and age for the accurate prediction of haemodilution during cardiopulmonary bypass. Interactive CardioVascular and Thoracic Surgery. doi:10.1093/icvts/ivy173 </br>
[10]Perel, A. (2018). The relationship between the decrease in haemoglobin concentration and the volume of fluids administered during resuscitation from septic shock may not be so “weak”. Critical Care,22(1). doi:10.1186/s13054-018-2118-6</br>
[11]Paydar, S., Bazrafkan, H., Golestani, N., Roozbeh, J., Akrami, A., & Moradi, A. M. (2014). Effects of Intravenous Fluid Therapy on Clinical and Biochemical Parameters of Trauma Patients. Emergency, 2(2), 90–95.</br>
[12]Ross, S. W., Christmas, A. B., Fischer, P. E., Holway, H., Seymour, R., Huntington, C. R., . . . Sing, R. F. (2018). Defining Dogma: Quantifying Crystalloid Hemodilution in a Prospective Randomized Control Trial with Blood Donation as a Model for Hemorrhage. Journal of the American College of Surgeons,227(3), 321-331. doi:10.1016/j.jamcollsurg.2018.05.005</br>
[13] Johnson AEW, Pollard TJ, Shen L, Lehman L, Feng M, Ghassemi M, Moody B, Szolovits P, Celi LA, Mark RG. MIMIC-III, a freely accessible critical care database. Scientific Data (2016). </br>
[14] Goldberger AL, Amaral LAN, Glass L, Hausdorff JM, Ivanov PCh, Mark RG, Mietus JE, Moody GB, Peng C-K, Stanley HE. PhysioBank, PhysioToolkit, and PhysioNet: Components of a New Research Resource for Complex Physiologic Signals. Circulation 101(23):e215-e220 [Circulation Electronic Pages; http://circ.ahajournals.org/content/101/23/e215.full]; 2000 (June 13).</br>
[15] Pollard, T. (n.d.). Getting Started. Retrieved from https://eicu-crd.mit.edu/</br>

