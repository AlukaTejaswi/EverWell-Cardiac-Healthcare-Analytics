USE EverwellCardiacDB
GO;

SELECT TOP 10 * FROM vw_AdmissionData;

/*Clinical_Outcome_Analytic*/

-- 1.What is the mortality rate among high-risk patients (DM + HTN + CKD)?
-- High Risk Mortality Rate = ( Expired High Risk Patients / Total High Risk Patients)​×100
SELECT
	ROUND(
	SUM(CASE 
		WHEN (DM = 1 AND HTN = 1 AND CKD = 1) AND OUTCOME = 'EXPIRY' 
			THEN 1.0 ELSE 0.0 END) /
	SUM(CASE	
		WHEN DM = 1 AND HTN = 1 AND CKD = 1 THEN 1.0 ELSE 0.0 END),
		2) AS HighRisk_MortalityRate
FROM vw_AdmissionData
---
SELECT
    ROUND(
        SUM(CASE WHEN OUTCOME = 'EXPIRY' THEN 1.0 ELSE 0.0 END) /
        COUNT(*),
    2) AS HighRiskMortalityRate
FROM vw_AdmissionData
WHERE DM = 1
  AND HTN = 1
  AND CKD = 1;
---------------------------------------------------------------------
-- 2.What percentage of total admissions are STEMI (heart attack) cases?
SELECT
	ROUND(
		SUM(CASE WHEN STEMI = 1 THEN 1.0 ELSE 0.0 END) * 100/
		COUNT(*),
		2) AS STEMIAdmissionPct
FROM vw_AdmissionData;

---------------------------------------------------------------------
-- 3.What is the multi-morbidity rate (patients with 2 or more chronic conditions)?
SELECT
	ROUND(
	SUM(CASE 
			WHEN (
					ISNULL(CAST(DM AS INT),0) +
                    ISNULL(CAST(HTN AS INT),0) +
                    ISNULL(CAST(CAD AS INT),0) +
                    ISNULL(CAST(CKD AS INT),0) +
                    ISNULL(CAST(PRIOR_CMP AS INT),0) 
				) >= 2
				THEN 1.0
				ELSE 0.0 
			END
		) * 100/
	COUNT(*),
	2) AS Multi_Morbidity_Rate
FROM vw_AdmissionData;

---------------------------------------------------------------------
-- 4.Which age group has the highest proportion of severe or critical cardiac cases?

SELECT * FROM(
SELECT
    CASE WHEN AGE < 18 THEN 'Paediatric'
         WHEN AGE >= 18 AND AGE < 65 THEN 'Adult'
         WHEN AGE >= 65 THEN 'Senior Citizen'
         ELSE 'UNKNOWN'
    END AS AgeGroup,
	COUNT(*) AS CardiacCasesCount,
	RANK() OVER(ORDER BY COUNT(*) DESC) AS Rnk
FROM vw_AdmissionData
WHERE STEMI = 1 OR HEART_FAILURE = 1 OR CARDIOGENIC_SHOCK = 1
GROUP BY 
	CASE WHEN AGE < 18 THEN 'Paediatric'
         WHEN AGE >= 18 AND AGE < 65 THEN 'Adult'
         WHEN AGE >= 65 THEN 'Senior Citizen'
         ELSE 'UNKNOWN'
    END
	) t 
WHERE Rnk = 1;

---------------------------------------------------------------------
-- 5.What percentage of rural patients present with severe conditions like STEMI, heart failure, or shock?

SELECT
    ROUND(
        SUM(CASE WHEN STEMI = 1 OR HEART_FAILURE = 1 OR SHOCK = 1 
				THEN 1.0
				ELSE 0.0
			END
        ) * 100 / COUNT(*),
    2) AS RuralSevereConditionPct
FROM vw_AdmissionData
WHERE RURAL = 'R';

----------------------------------------------------------
-- 6.What percentage of severe conditions like STEMI, heart failure, or shock in rural patients?

SELECT
	ROUND(
		SUM(CASE WHEN RURAL= 'R' THEN 1.0 ELSE 0.0 END) * 100/
		COUNT(*) ,
		2) AS RuralWithHeartConditions
FROM vw_AdmissionData
WHERE STEMI = 1 OR HEART_FAILURE = 1 OR CARDIOGENIC_SHOCK = 1;

---------------------------------------------------------------------
-- 7.Which months show the highest number of severe cardiac cases?
SELECT
	month_year,
	COUNT(*) AS CardiacCasesCount
FROM vw_AdmissionData
WHERE STEMI = 1 OR HEART_FAILURE = 1 OR CARDIOGENIC_SHOCK = 1
GROUP BY month_year
ORDER BY  CardiacCasesCount DESC;

---------------------------------------------------------------------
-- 8.Are severe cardiac cases more frequent on weekends compared to weekdays?
SELECT
	CASE 
		WHEN DATENAME(DW,D_O_A) IN ('Sunday', 'Saturday') then 'WeekEnd'
		ELSE 'WeekDay'
		END
	 AS Days,
	COUNT(*) AS CardiacCasesCount
FROM vw_AdmissionData
WHERE STEMI = 1 OR HEART_FAILURE = 1 OR CARDIOGENIC_SHOCK = 1
GROUP BY 
	CASE 
		WHEN DATENAME(DW,D_O_A) IN ('Sunday', 'Saturday') then 'WeekEnd'
		ELSE 'WeekDay'
		END;
---------------------------------------------------------------------
-- 9.How does elevated BNP level relate to patient mortality outcomes?
SELECT
	CASE
		WHEN BNP < 100 THEN 'Normal'
		WHEN BNP BETWEEN 100 AND 400 THEN 'Moderate'
		ELSE 'High'
		END AS BNP_Level,
	COUNT(*) AS TotalExpiry
FROM vw_AdmissionData
WHERE OUTCOME = 'EXPIRY'
GROUP BY 
	CASE
		WHEN BNP < 100 THEN 'Normal'
		WHEN BNP BETWEEN 100 AND 400 THEN 'Moderate'
		ELSE 'High'
		END 
ORDER BY TotalExpiry;

---------------------------------------------------------------------
-- 10.What percentage of expired patients had renal dysfunction (high creatinine or CKD)?
SELECT
	ROUND(
		SUM(
			CASE 
				WHEN CKD = 1 OR CREATININE > 1.2 THEN 1.0 ELSE 0.0 END
			)/
		COUNT(*) * 100,
		2) AS RenalDysfunctionAmongExpiredPct
FROM vw_AdmissionData
WHERE OUTCOME = 'EXPIRY';
