-- Q2 Base querry to extract data for milk and bread, grouped by food_code and payroll year. Includes data for average salary across industries over time. 
SELECT 
	payroll_year, 
	ROUND(AVG(average_salary),2) AS average_salary,
	currency,
	food_type,
	ROUND(AVG(average_value),2) AS average_price,
	food_quantity,
	measure_unit
FROM 
	primary_final_v4
WHERE 
	food_code IN ('114201', '111301')  
GROUP BY 
	food_code, payroll_year;
	
/* The querry calculates the purchasing power for 'Bread' and 'Milk' by analyzing the average salary and food prices over time.
Payroll_years subquery was joined with bread_milk_avg_salary to get results for the the first and last comparable periods (years).
The final output is grouped by payroll year, food code, and food type.
*/
WITH bread_milk_avg_salary AS (
	SELECT 
		payroll_year, 
 		ROUND(AVG(average_salary), 2) AS average_salary,
		currency,
		food_type,
		ROUND(AVG(average_value), 2) AS average_price,
		food_quantity,
		measure_unit
	FROM 
		primary_final_v4
	WHERE 
		food_code IN ('114201', '111301')  
	GROUP BY 
		payroll_year, food_type, currency, food_quantity, measure_unit
),
payroll_years AS (
	SELECT 
		MIN(payroll_year) AS min_year,
		MAX(payroll_year) AS max_year
	FROM 
		bread_milk_avg_salary
) 
SELECT
	bmas.payroll_year,
	bmas.average_salary AS average_salary,
	bmas.currency,
	bmas.food_type,
	bmas.average_price,
	bmas.currency,
	ROUND((AVG(bmas.average_salary) / bmas.average_price), 2) AS food_purchasing_power,
	bmas.measure_unit
FROM 
	bread_milk_avg_salary AS bmas
JOIN
	payroll_years AS py 
ON 
	1=1 -- join condition for cross join
WHERE 
	bmas.payroll_year = py.min_year OR bmas.payroll_year = py.max_year
GROUP BY
	bmas.payroll_year, bmas.food_type, bmas.currency, bmas.average_price, bmas.measure_unit
ORDER BY 
	bmas.food_type, bmas.payroll_year;