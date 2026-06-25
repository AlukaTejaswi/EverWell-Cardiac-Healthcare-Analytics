USE EverwellCardiacDB
GO;
EXEC sp_refreshview 'vw_AdmissionData';

SELECT  * FROM vw_AdmissionData;
------Admission Analysis----

-- 1.What is the total number of patients admitted in the hospital?

SELECT
	COUNT(*) AS Totalpatients
FROM vw_AdmissionData;

-------------------------------------------------
-- 2.What percentage of admissions are emergency cases?
SELECT
	ROUND(
	SUM(CASE WHEN TYPE_OF_ADMISSION_EMERGENCY_OPD = 'E' THEN 1.0 ELSE 0.0 END) * 100/
	COUNT(*), 
	2) AS EmergencyAdmissionPct
FROM vw_AdmissionData;

-------------------------------------------------
-- 3.What percentage of admissions come through OPD (Outpatient Department)?
SELECT
	ROUND(
	SUM(CASE WHEN TYPE_OF_ADMISSION_EMERGENCY_OPD = 'O' THEN 1.0 ELSE 0.0 END) * 100/
	COUNT(*), 
	2) AS OPDAdmissionPct
FROM vw_AdmissionData;

-------------------------------------------------
-- 4.What is the average length of stay for admitted patients?
SELECT
	AVG(DURATION_OF_STAY) AS AVG_LengthOfStay
FROM vw_AdmissionData;

-------------------------------------------------
-- 5.How are admissions distributed across different age groups?
SELECT
    CASE WHEN AGE < 18 THEN 'Paediatric'
         WHEN AGE >= 18 AND AGE < 65 THEN 'Adult'
         WHEN AGE >= 65 THEN 'Senior Citizen'
         ELSE 'UNKNOWN'
    END AS AgeGroup,
    COUNT(*) AS TotalAdmissions
FROM vw_AdmissionData
GROUP BY    
    CASE WHEN AGE < 18 THEN 'Paediatric'
         WHEN AGE >= 18 AND AGE < 65 THEN 'Adult'
         WHEN AGE >= 65 THEN 'Senior Citizen'
         ELSE 'UNKNOWN'
    END 
ORDER BY TotalAdmissions DESC;

-------------------------------------------------
-- 6.What is the gender-wise distribution of hospital admissions?
SELECT
    GENDER,
    COUNT(*) AS TotalAdmissions
FROM vw_AdmissionData
GROUP BY GENDER 
ORDER BY TotalAdmissions DESC;

-------------------------------------------------
-- 7.What is the split of admissions between rural and urban patients?
SELECT
    RURAL,
    COUNT(*) AS TotalAdmissions
FROM vw_AdmissionData
GROUP BY RURAL 
ORDER BY TotalAdmissions DESC;

-------------------------------------------------
-- 8.What is the monthly trend of patient admissions over time?
SELECT
    YEAR(D_O_D) AS YearOfAdmisison,
    MONTH(D_O_D) AS MonthOfAdmission,
    COUNT(*) AS TotalAdmisisons
FROM vw_AdmissionData
WHERE YEAR(D_O_D) IS NOT NULL OR MONTH(D_O_D) IS NOT NULL
GROUP BY 
    YEAR(D_O_D),
    MONTH(D_O_D)
ORDER BY 
    YearOfAdmisison,
    MonthOfAdmission;
-----------
SELECT
    month_year,
    COUNT(*) AS TotalAdmisisons
FROM vw_AdmissionData
GROUP BY 
    month_year
ORDER BY 
    month_year;

-------------------------------------------------
-- 9.What percentage of admissions are high-risk (DM, HTN, CKD patients)?
SELECT
    ROUND(
    SUM(
        CASE    
            WHEN DM = 1 THEN 1.0
            WHEN HTN = 1 THEN 1.0
            WHEN CKD = 1 THEN 1.0
            ELSE 0.0
            END) * 100 /
           COUNT(*),
            2)AS HighRiskPateintsPct
FROM vw_AdmissionData
--------
SELECT
    ROUND(
    SUM(
        CASE    
            WHEN DM = 1 OR HTN = 1 OR CKD = 1 THEN 1.0
            ELSE 0.0
            END) * 100 /
           COUNT(*),
            2)AS HighRiskPateintsPct
FROM vw_AdmissionData;
-------------------------------------------------
-- 10.What is the ICU admission rate among all admitted patients?
--ICU Admission Rate = (ICU patients / Total admissions) × 100

SELECT 
    ROUND(
        SUM(CASE WHEN duration_of_intensive_unit_stay > 0 THEN 1.0 ELSE 0.0 END) /
        COUNT(*),
        2) * 100 AS ICUAdmisisonRate
FROM vw_AdmissionData;