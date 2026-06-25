USE EverwellCardiacDB
GO;
SELECT  * FROM vw_AdmissionData;
--------- Hospital Utilisation Analysis---------

-- 1.ICU Utilisation Rate
--ICU Utilisation Rate = (ICU Bed Days Used / ICU Bed Capacity) × 100
SELECT 
    ROUND(
        SUM(duration_of_intensive_unit_stay) * 100.0
        / COUNT(*),
    2) AS ICU_Utilisation_Proxy
FROM vw_AdmissionData;
------------------------------
-- 2.Average ICU Length of Stay
SELECT
	AVG(duration_of_intensive_unit_stay) AS Avg_ICU_Stay
FROM vw_AdmissionData;
------------------------------------
-- 3.ICU Dependency Rate
-- ICU Dependency Rate = (Patients with ICU stay > 0 / Total patients) × 100

SELECT 
    ROUND(
        SUM(CASE WHEN duration_of_intensive_unit_stay > 0 THEN 1.0 ELSE 0.0 END) /
        COUNT(*),
        2) * 100 AS ICUDependencyRate
FROM vw_AdmissionData;

---------------------------------------
-- 4.ICU Stay Duration Distribution
SELECT
	CASE 
		WHEN duration_of_intensive_unit_stay = 0 THEN 'No ICU Stay'
		WHEN duration_of_intensive_unit_stay BETWEEN 1 AND 3 THEN 'Low Critical Risk'
		WHEN duration_of_intensive_unit_stay BETWEEN 4 AND 7 THEN 'Medium Critical Risk'
		ELSE 'High Critical Risk'
	END AS ICU_Risk_Category,
	COUNT(*) AS TotalPatients
FROM vw_AdmissionData
GROUP BY 
	CASE 
		WHEN duration_of_intensive_unit_stay = 0 THEN 'No ICU Stay'
		WHEN duration_of_intensive_unit_stay BETWEEN 1 AND 3 THEN 'Low Critical Risk'
		WHEN duration_of_intensive_unit_stay BETWEEN 4 AND 7 THEN 'Medium Critical Risk'
		ELSE 'High Critical Risk'
	END;
-------------------------------------
-- 5.Bed Occupancy Rate 

--Bed Occupancy Rate = (Total Patient Bed Days / Total Available Bed Days) × 100
-- bed usage = SUM(duration of stay)
SELECT
	ROUND(
		SUM(DURATION_OF_STAY) / COUNT(*),
		2
	) AS Bed_Occupancy_Rate
FROM vw_AdmissionData;
