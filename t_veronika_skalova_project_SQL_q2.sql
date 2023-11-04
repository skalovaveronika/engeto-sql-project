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