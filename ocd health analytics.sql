use healthcare;

select * from ocd_patient_dataset;

/*Questions Solved*/ 

/*Patient Demographics and Insights*/

/*1.What is the average age of patients diagnosed with OCD?*/
SELECT ROUND(AVG(AGE))
FROM ocd_patient_dataset
WHERE `OCD DIAGNOSIS DATE` IS NOT NULL;
-- 47

/*2.Is there a significant gender distribution among OCD diagnoses?*/
SELECT GENDER, COUNT(*)
FROM ocd_patient_dataset
GROUP BY GENDER;
-- Female  747
-- Male	   753


/*3.What is the correlation between marital status and OCD diagnosis frequency?*/
SELECT `MARITAL STATUS`, Count(*) as 'Total Patients'
FROM ocd_patient_dataset
WHERE 'OCD DIAGNOSIS DATE' IS NOT NULL
GROUP BY `MARITAL STATUS`;
-- Single	511
-- Divorced	482
-- Married	507

/*4.How does the educational level of patients affect the duration of symptoms before diagnosis?*/
SELECT `EDUCATION LEVEL`, ROUND(AVG(`Duration of Symptoms (months)`)) AS Avg_Symptom_Duration
FROM ocd_patient_dataset
GROUP BY `EDUCATION LEVEL`;
-- Some College	    122
-- College Degree	125
-- High School	    121
-- Graduate Degree	118

/*Family and Medical History*/

/*5.What percentage of patients have a family history of OCD?*/
SELECT SUM(CASE WHEN `Family History of OCD` ='YES' THEN 1 ELSE 0  END ) AS 'FAMILY HISTORY-YES', Count(*) as 'TOTAL PATIENTS',
ROUND(SUM(CASE WHEN `Family History of OCD` ='YES' THEN 1 ELSE 0  END )/COUNT(*) *100) AS 'PERCENTAGE'
FROM ocd_patient_dataset;
-- 51 

/*6.How does a family history of OCD influence the Y-BOCS scores for obsessions and compulsions?*/

SELECT `Family History of OCD`, ROUND(AVG(`Y-BOCS Score (Obsessions)`)) AS 'AVG OBSESSIONS SCORE',
ROUND(AVG(`Y-BOCS Score (Compulsions)`)) AS 'AVG COMPULSIONS SCORE'
FROM ocd_patient_dataset
GROUP BY `Family History of OCD`;
-- Family History of ODC  AVG OBSESSIONS SCORE   AVG COMPULSIONS SCORE
--      No	                    20	                  20
--      Yes	                    20	                  19

/*7.What are the most common previous diagnoses among OCD patients?*/
SELECT `PREVIOUS DIAGNOSES`, COUNT(*) AS 'COUNT'
FROM ocd_patient_dataset
GROUP BY `PREVIOUS DIAGNOSES`;
-- PREVIOUS DIAGNOSES     COUNT
--    MDD	               345
--    None                 248
--    PTSD	               296
--    GAD	               298
--   Panic Disorder	       313

select * from ocd_patient_dataset;
/*Symptom Duration and Diagnosis*/

/*8.What is the average duration of symptoms before OCD diagnosis?*/

SELECT ROUND(AVG(`Duration of Symptoms (months)`)) AS 'AVG_DURATION_BEFORE_DIAGNSES'
FROM ocd_patient_dataset 
WHERE `PREVIOUS DIAGNOSES`='NONE';
-- 122 Months


/*9.What percentage of OCD patients also have depression or anxiety diagnoses?*/
SELECT ROUND(SUM(CASE WHEN `DEPRESSION DIAGNOSIS`='YES' THEN 1 ELSE 0 END)/COUNT(*)*100) AS 'DEPRESSION',
ROUND(SUM(CASE WHEN `ANXIETY DIAGNOSIS`='YES' THEN 1 ELSE 0 END)/COUNT(*)*100) AS 'ANXIETY'
FROM ocd_patient_dataset;
-- DEPRESSION ANXIETY
-- 51         50

/*10.Which medications are most commonly prescribed for OCD patients with comorbid depression or anxiety?*/
SELECT DISTINCT MEDICATIONS, count(*)
FROM ocd_patient_dataset
WHERE `DEPRESSION DIAGNOSIS`='YES' AND MEDICATIONS NOT IN ('NONE') 
group by MEDICATIONS;
-- SNRI 204
-- SSRI 191
-- Benzodiazepine 206


SELECT DISTINCT MEDICATIONS, count(*)
FROM ocd_patient_dataset
WHERE `ANXIETY DIAGNOSIS`='YES' AND MEDICATIONS NOT IN ('NONE') 
group by MEDICATIONS;
-- SNRI 185
-- SSRI 171
-- Benzodiazepine 187

/*11.What is the overall trend of OCD diagnoses over time (by year or month)?*/
SELECT LEFT(`OCD Diagnosis Date`,4) AS 'YEAR', COUNT(*) AS 'COUNT'
FROM ocd_patient_dataset
WHERE `OCD Diagnosis Date` IS NOT NULL
GROUP BY 1
ORDER BY 1;
-- YEAR COUNT
-- 2013  18
-- 2014	157
-- 2015	170
-- 2016	163
-- 2017	163
-- 2018	204
-- 2019	167
-- 2020	169
-- 2021	150
-- 2022	139

/*12.Are there geographic or ethnic trends in OCD diagnoses?*/
SELECT ETHNICITY, COUNT(*) AS PATIENT_COUNT
FROM ocd_patient_dataset
GROUP BY ETHNICITY;
-- ETHNICITY PATIENT_COUNT
-- African	    324
-- Hispanic	    392
-- Asian	    386
-- Caucasian	398


select * from ocd_patient_dataset;



