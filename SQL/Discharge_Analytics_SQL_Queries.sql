USE EverwellCardiacDB
GO;

SELECT TOP 10 * FROM AdmissionData;

------Discharge Analysis----

-- 1.What is the total number of patient discharges in the hospital?
SELECT COUNT(*) AS TotalPatientsDischared
FROM vw_AdmissionData
WHERE OUTCOME = 'DISCHARGE';

-------------------------------------------------------------
-- 2.What is the average daily discharge rate?

--Avg daily discharge rate = total no of discharges/ no of duration of days

SELECT 
    CAST(
        COUNT(*) * 1.0 / SUM(DURATION_OF_STAY)
    AS DECIMAL(10,2)) AS Avg_DailyDischargeRate
FROM vw_AdmissionData
WHERE OUTCOME = 'DISCHARGE';

--------------------------------------------------------------
-- 3.What is the discharge trend by month or year?
SELECT
    YEAR(D_O_D) AS Discharge_Year,
    MONTH(D_O_D) AS Discharge_Month,
    COUNT(*) AS TotalDischages
FROM vw_AdmissionData
WHERE OUTCOME = 'DISCHARGE' AND YEAR(D_O_D) IS NOT NULL OR MONTH(D_O_D) IS NOT NULL
GROUP BY 
    YEAR(D_O_D),
    MONTH(D_O_D)
ORDER BY Discharge_Year,Discharge_Month;

-------------------------------------------------------------
-- 4.What is the distribution of discharges by day of the week?
SELECT
DATENAME(DW,D_O_D) AS DAY,
COUNT(*) AS TotalDischarges
FROM vw_AdmissionData
WHERE OUTCOME = 'DISCHARGE' AND DATENAME(DW,D_O_D) IS NOT NULL
GROUP BY DATENAME(DW,D_O_D),
    DATEPART(DW,D_O_D)
ORDER BY DATEPART(DW,D_O_D);

---------------------------------------------------------------------
-- 5.What is the discharge rate compared to total admissions?
SELECT 
    ROUND(
        SUM(CASE WHEN OUTCOME = 'DISCHARGE' THEN 1 ELSE 0 END) * 1.0/
        COUNT(*) , 2) AS Discharge_Rate
FROM vw_AdmissionData
-----------
SELECT 
    ROUND(
        SUM(CASE WHEN OUTCOME = 'DISCHARGE' THEN 1.0 ELSE 0.0 END)
        / COUNT(*),
    4
) AS Discharge_Rate
FROM vw_AdmissionData;
----------
SELECT 
    ROUND(
        SUM(CASE WHEN OUTCOME = 'DISCHARGE' THEN 1.0 ELSE 0.0 END)
        * 100.0 / COUNT(*),
    2) AS Discharge_Rate_Percentage
FROM vw_AdmissionData;
----------------------------------------------------------------------
-- 6.What is the average length of stay for discharged patients?
SELECT 
   AVG(DURATION_OF_STAY) AS Avg_LengthOfStay
FROM vw_AdmissionData
WHERE OUTCOME = 'DISCHARGE';

--------------------------------------------------------------------------
-- 7.How many patients were discharged vs expired in hospital?

SELECT 
OUTCOME,
COUNT(*) AS TotalPatients
FROM vw_AdmissionData
WHERE OUTCOME IN ('DISCHARGE', 'EXPIRY')
GROUP BY OUTCOME;
-----------------------------------------------------------------------
-- 8.What is the discharge distribution by gender?
SELECT
    GENDER,
    COUNT(*) AS TotalDischarges
FROM vw_AdmissionData
WHERE OUTCOME = 'DISCHARGE'
GROUP BY GENDER 
ORDER BY TotalDischarges DESC;

-----------------------------------------------------------------------------
-- 9.How does discharge pattern vary across different age groups?
SELECT
    CASE WHEN AGE < 18 THEN 'Paediatric'
         WHEN AGE >= 18 AND AGE < 65 THEN 'Adult'
         WHEN AGE >= 65 THEN 'Senior Citizen'
         ELSE 'UNKNOWN'
    END AS AgeGroup,
    COUNT(*) AS TotalDischarges
FROM vw_AdmissionData
WHERE OUTCOME = 'DISCHARGE'
GROUP BY    
    CASE WHEN AGE < 18 THEN 'Paediatric'
         WHEN AGE >= 18 AND AGE < 65 THEN 'Adult'
         WHEN AGE >= 65 THEN 'Senior Citizen'
         ELSE 'UNKNOWN'
    END 
ORDER BY TotalDischarges DESC;
-----------------------------------------------------------------------------------
-- 10.What percentage of patients were discharged against medical advice (DAMA)?

SELECT
    ROUND(
        SUM(CASE WHEN OUTCOME = 'DAMA' THEN 1.0 ELSE 0.0 END) * 100.0 /
        COUNT(*),
    2) AS DAMA_Percentage
FROM vw_AdmissionData
WHERE OUTCOME IN ('DAMA', 'DISCHARGE');
--------------
SELECT
    ROUND(
        SUM(CASE WHEN OUTCOME = 'DAMA' THEN 1.0 ELSE 0.0 END) * 100.0 /
        SUM(CASE WHEN OUTCOME IN ('DAMA', 'DISCHARGE') THEN 1.0 ELSE 0.0 END),
    2) AS DAMA_Percentage
FROM vw_AdmissionData;