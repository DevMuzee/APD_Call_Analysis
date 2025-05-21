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



