USE [apd_call]
--1. Improving Response Times
--Problem: The department wants to understand the factors that affect response times. 
--You are tasked with identifying patterns where response times are high and suggesting changes to reduce these times.
SELECT incident_type, 
	council_district,
	response_day_of_week,
	response_hour,
	AVG(response_time) AS avg_response_time
FROM [dbo].[apd_calls]
--WHERE council_district=10
GROUP BY incident_type, council_district, response_day_of_week,response_hour
ORDER BY AVG(response_time) DESC; ----Heatmap suggested

SELECT final_problem_category, priority_level, AVG(response_time)
FROM [dbo].[apd_calls]
WHERE final_problem_category='Administrative'
GROUP BY priority_level, final_problem_category
ORDER BY priority_level ASC;

--2. Identifying Mental Health-Related Incidents
--Problem: The city council is concerned about mental health-related incidents and wants a report detailing how often these incidents occur, 
--their outcomes, and any patterns.

SELECT incident_type,
	COUNT(*) AS total_incidents,
	AVG(response_time) AS avg_response_time,
    call_disposition_description AS outcome,
    response_day_of_week AS day_of_week,
    response_hour AS hour_of_day
FROM [dbo].[apd_calls]
WHERE mental_health_flag = 'Mental Health Incident'
GROUP BY incident_type, call_disposition_description,response_day_of_week, response_hour
ORDER BY 2 DESC;

SELECT *
FROM [dbo].[apd_calls];

/*SELECT number_of_units_arrived, priority_level, final_problem_description, COUNT(*) AS count_unit_arrived
FROM [dbo].[apd_calls]
GROUP BY number_of_units_arrived, priority_level, final_problem_description
ORDER BY number_of_units_arrived*/

--3. Assessing Resource Allocation and Unit Efficiency
--Problem: The APD needs to optimize the number of units dispatched to incidents, 
--ensuring enough officers are present without over-allocating resources. 

WITH Raue AS (
	SELECT incident_type,
		AVG(CAST(COALESCE(number_of_units_arrived, 0) AS BIGINT)) AS avg_unit_dispatched,
		AVG(CAST(COALESCE(unit_time_on_scene, 0) AS BIGINT)) AS avg_time_on_scene
	FROM [dbo].[apd_calls]
	GROUP BY incident_type
)
SELECT *
FROM Raue
ORDER BY avg_unit_dispatched DESC;

		----OR

SELECT incident_type,
	AVG(CAST(COALESCE(number_of_units_arrived, 0) AS BIGINT)) AS avg_unit_dispatched,
	MAX(CAST(COALESCE(number_of_units_arrived, 0) AS BIGINT)) AS max_units_dispatched,
	MIN(CAST(COALESCE(number_of_units_arrived, 0) AS BIGINT)) AS min_unit_dispatched,
	AVG(CAST(COALESCE(unit_time_on_scene, 0) AS BIGINT)) AS avg_time_on_scene
FROM [dbo].[apd_calls]
GROUP BY incident_type
ORDER BY AVG(CAST(COALESCE(number_of_units_arrived, 0) AS BIGINT)) DESC;


/*SELECT final_problem_category,SUM(number_of_units_arrived)
FROM [dbo].[apd_calls]
GROUP BY final_problem_category
ORDER BY SUM(number_of_units_arrived) DESC;*/

--4. Analyzing Incidents by Day of Week and Hour
--Problem: The department wants to understand peak times for different types of incidents to adjust patrol schedules accordingly.

SELECT response_day_of_week AS day_of_week,
	response_hour AS hour_of_day,
	COUNT(*) AS total_incidents,
	AVG(response_time) AS avg_response_time
FROM [dbo].[apd_calls]
GROUP BY response_day_of_week, response_hour
ORDER BY 3 DESC;


--5. Monitoring High-Priority Incidents
--Problem: High-priority incidents (priority level 0 or 1) need special attention to ensure that they are being handled efficiently. 
--The APD wants a report showing these incidents, their outcomes, and any injuries sustained by officers or civilians.

SELECT incident_type,
	response_time, 
	officer_injured_killed_count,
	subject_injured_killed_count, 
	cther_injured_killed_count,
	call_disposition_description,
	COUNT(*) AS total_high_piority
FROM [dbo].[apd_calls]
WHERE priority_level IN (0, 1)
GROUP BY incident_type, response_time, 
		officer_injured_killed_count, cther_injured_killed_count, 
		call_disposition_description, subject_injured_killed_count
ORDER BY 7;

/*SELECT incident_number, incident_type, call_disposition_description, 
	ISNULL(SUM(officer_injured_killed_count),0), 
	ISNULL(SUM(subject_injured_killed_count),0) 
	--SUM(cther_injured_killed_count)
FROM [dbo].[apd_calls]
GROUP BY incident_number, incident_type, call_disposition_description*/

SELECT *
FROM [dbo].[apd_calls]

-- Incident outcome analysis, exploring how different types of incidents (initial vs. final problem descriptions) are resolved.

SELECT initial_problem_description, final_problem_description, final_problem_category, call_disposition_description
FROM [dbo].[apd_calls]

SELECT sector, AVG(unit_time_on_scene)
FROM [dbo].[apd_calls]
GROUP BY sector
