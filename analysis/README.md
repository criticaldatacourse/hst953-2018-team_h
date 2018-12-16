Prediction Model for Hemodilution Effect among patients with Fluid Resuscitation

Background:
The administration of intravenous fluid (resuscitation) is one of the most common interventions in intensive care medicine. Decreased concentration of hemoglobin in intravascular plasma volume due to IV fluid infusion is called hemodilution. Clear guidelines do not exist for determination of the expected amount of hemodilution after fluid administration. The main goal of this study is to qualify and identify any correlation in the change in hemoglobin to the amount of fluid administered, and to evaluate also for any other factors that may contribute to hemodilution.

Methods:
Using the MIMIC III database (2001 – 2012), a study cohort of patients from 18 – 80 years of age, who didn’t have a diagnosis of internal or external bleeding or any bleeding disorder, and were given normal saline within the first 24 hours of their ICU stay, was formed. Covariates like gender, weight, urine output over 6 hours, creatinine levels at admission, hemoglobin at baseline and after 24 hours, and total amount of fluid administered were collected. Six prediction models were built, viz., linear regression, stepwise linear regression (AIC), random forest, support vector machine, gradient boosting machine, neural network.

Repository guide:
Analysis folder has both sql and r files along with the two csv files which are utilized in the analysis. Folder named sql has queries for obtaining data from MIMIC III database. We used that data for our prediction modelling. Analysis_original markdown file has code for modellling using non transformed variables and analysis_transformd markdown file has code for modelling using transformed variables. 

Results:
Comparing mean square error of all six models, SVM with MSE of 1.02g/dl was finalized as best model. Model performance is better near the median change in hemoglobin among the cohort and has increasing error on both extremes.

Conclusion: Our study has proven that hemodilution exists in the critically ill cohort using normal saline over the first 24 hours, but there is either no simple model to predict the expected drop or we are limited by the data.


