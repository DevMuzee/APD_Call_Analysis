--Q2.What are the top 5 busiest geographic areas in terms of 911 calls, and what is the average response time for each of these areas?
SELECT 
	geo_ID,
	CASE 
		WHEN geo_ID = '482089992192' THEN 'area_192' 
		WHEN geo_ID = '484539990016' THEN 'area_016' 
		WHEN geo_ID = '484910006272' THEN 'area_272' 
		WHEN geo_ID = '484529995776' THEN 'area_776'
		ELSE 'Area_Zero'  
	END AS GEO_ID_name,
	COUNT(*) AS area_count,
	AVG(response_time) AS avg_response_time
FROM [dbo].[apd_calls]
GROUP BY geo_ID
ORDER BY 2; ----sort by any columns



-- Q10.	For each sector, rank the geographic areas by total number of 911 calls and show the response time for each area.
SELECT 
	sector, 
	CAST(geo_ID AS bigint) AS geo_ID, 
	COUNT(CAST(incident_number AS VARCHAR)) AS total_911_calls,
	AVG(response_time) AS avg_response_time,
	RANK() OVER (PARTITION BY sector ORDER BY COUNT(CAST(incident_number AS VARCHAR)) DESC) AS area_rank
FROM [dbo].[apd_calls]
GROUP BY sector, CAST(geo_ID AS bigint)
ORDER BY sector, area_rank;



--Q15.	Which council districts have the highest average response times?
WITH cn_district AS (
	SELECT council_district, 
		AVG(response_time) AS avg_response_time
	FROM [dbo].[apd_calls]
	GROUP BY council_district
)

SELECT TOP 1
	council_district,
	avg_response_time AS highest_avg_response_time
FROM cn_district
ORDER BY avg_response_time DESC;

				--OR--

SELECT TOP 1 
	council_district, 
	AVG(response_time) AS avg_response_time
FROM [dbo].[apd_calls]
GROUP BY council_district
ORDER BY AVG(response_time) DESC;



-- 29.	What is the average number of units dispatched to incidents based on the incident type?
SELECT incident_type,
	AVG(number_of_units_arrived) AS avg_units_dispatched
FROM [dbo].[apd_calls]
GROUP BY incident_type
ORDER BY AVG(number_of_units_arrived);


--What is the average response time for all incidents involving mental health issues?
SELECT 
    AVG(response_time) AS avg_response_time_mental_health
FROM 
    apd_call
WHERE 
    mental_health_flag = 'Mental Health Incident';


--Find the average response time for each incident type and compare it with the overall average response time
WITH incident_avg AS (
    SELECT 
        incident_type,
        AVG(CAST(response_time AS BIGINT)) AS avg_response_time
    FROM 
        apd_call
    GROUP BY 
        incident_type
),
overall_avg AS (
    SELECT 
        AVG(CAST(response_time AS BIGINT)) AS overall_avg_response_time
    FROM 
        apd_call
)
SELECT 
    ia.incident_type,
    ia.avg_response_time,
    oa.overall_avg_response_time
FROM 
    incident_avg ia, overall_avg oa;


--What is the total number of mental health-related incidents, and how has this changed over time?
SELECT 
    DATEPART(YEAR, response_datetime) AS year,
    DATEPART(MONTH, response_datetime) AS month,
    COUNT(*) AS total_mental_health_incidents
FROM 
    apd_call
WHERE 
    mental_health_flag = 'Mental Health Incident'
    AND TRY_CAST(response_time AS INT) IS NOT NULL  -- Ensures only numeric response_time values
GROUP BY 
    DATEPART(YEAR, response_datetime), 
    DATEPART(MONTH, response_datetime)
ORDER BY 
    year, month;


--How many incidents were initiated by officers in the field compared to those dispatched via 911 calls?
select
	incident_type,
	count(*) AS incident_count
from
	apd_call
group by
	incident_type;


---20.	What are the top 3 most frequent final problem descriptions?--
SELECT TOP 3  final_problem_description,
COUNT(final_problem_description) AS frequent_final_problem_description
FROM [dbo].[apd]
GROUP BY final_problem_description
ORDER BY frequent_final_problem_description DESC



----26.	Which incidents have the longest on-scene time, and how does this correlate with the incident type or priority level?---
SELECT 
    incident_type, 
    priority_level, 
    MAX(unit_time_on_scene) AS max_on_scene_time, 
    AVG(unit_time_on_scene) AS avg_on_scene_time
FROM [dbo].[apd]
GROUP BY 
    incident_type, 
    priority_level
ORDER BY 
    max_on_scene_time DESC;


------28.	How many incidents were initiated by officers in the field compared to those dispatched via 911 calls?----
SELECT 
    incident_type, 
    COUNT(*) AS incident_count
FROM [dbo].[apd]
GROUP BY 
    incident_type;



