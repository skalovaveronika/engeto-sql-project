-- Q2 Base querry to extract data for milk and bread, grouped by food_code and payroll year
SELECT 
	payroll_year, 
	industry_code,
	industry_name,
	average_salary,
	currency,
	food_code,
	food_type,
	average_value,
	food_quantity,
	measure_unit
FROM 
	primary_final_v4
WHERE 
	food_code IN ('114201', '111301')  
GROUP BY 
	food_code, payroll_year;
	
-- Q2 in progress
WITH bread_milk_avg_salary AS (
	SELECT 
		payroll_year, 
		food_code,
		food_type,
		average_salary,
		currency,
		average_value,
		food_quantity,
		measure_unit
	FROM 
		primary_final_v4
	WHERE 
		food_code IN ('114201', '111301') 
	GROUP BY 
		food_code, payroll_year
) 
SELECT
	payroll_year,
	AVG(average_salary) AS average_salary_across_industries,
	currency,
	food_code,
	food_type,
	average_value AS average_price,
	currency,
	ROUND((AVG(average_salary) / average_value), 2) AS food_purchasing_power,
	measure_unit
FROM 
	bread_milk_avg_salary 
GROUP BY 
	payroll_year, food_code;
