-- Q1 Base querry
SELECT
	payroll_year,
	industry_code,
	industry_name,
	average_salary,
	LAG(average_salary) OVER (PARTITION BY industry_code ORDER BY payroll_year) AS previous_yr_avg_salary
FROM 
	primary_final_v4 pf
GROUP BY 
	payroll_year, industry_code
ORDER BY 
	industry_code, payroll_year; 

/* Calculated Q1 salary change status by year and industry for the primary data set.
This query calculates the percentage change in average salary (Q1) between consecutive years for each industry.
It uses LAG function to compare with the previous year's average salary.
The result includes the percentage change as 'salary_change_percentage' and categorizes it as 'Increase,' 'Decrease,' or 'N/A' in the 'salary_change_status' column.
*/
WITH salary_changes_q1 AS (
	SELECT
		payroll_year,
		industry_code,
		industry_name,
		average_salary,
		LAG(average_salary) OVER (PARTITION BY industry_code ORDER BY payroll_year) AS previous_yr_avg_salary
	FROM 
		primary_final_v4 pf
	GROUP BY 
		payroll_year, industry_code
)
SELECT *,
	ROUND((average_salary - previous_yr_avg_salary) / previous_yr_avg_salary * 100,2) AS salary_change_percentage,
	CASE 
		WHEN ((average_salary - previous_yr_avg_salary) / previous_yr_avg_salary * 100) > 0 THEN 'Increase'
		WHEN ((average_salary - previous_yr_avg_salary) / previous_yr_avg_salary * 100) < 0 THEN 'Decrease'
		ELSE 'Data not available'
	END 
	AS salary_change_status
FROM 
	salary_changes_q1
ORDER BY 
	industry_code, payroll_year;

/* Used the same CTE 'salary_changes_q1' to get the overall % change in average salary by industry across the years, which perhaps answers the original question a little better. 
   The results are grouped by industry code and name, and the industries are ordered by the overall salary change percentage in ascending order.
*/
WITH salary_changes_q1 AS (
	SELECT
		payroll_year,
		industry_code,
		industry_name,
		average_salary,
		LAG(average_salary) OVER (PARTITION BY industry_code ORDER BY payroll_year) AS previous_yr_avg_salary
	FROM 
		primary_final_v4 pf
	GROUP BY 
		payroll_year, industry_code
)
SELECT
	industry_code,
	industry_name,
	ROUND(SUM(average_salary - previous_yr_avg_salary) / SUM(previous_yr_avg_salary) * 100, 2) AS average_salary_change_percentage
FROM 
	salary_changes_q1
GROUP BY 
	industry_code, industry_name
ORDER BY 
	average_salary_change_percentage ASC;


