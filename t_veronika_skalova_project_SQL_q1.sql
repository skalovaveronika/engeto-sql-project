-- Q1 base querry
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