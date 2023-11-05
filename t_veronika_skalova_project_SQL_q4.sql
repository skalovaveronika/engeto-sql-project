SELECT 
	payroll_year,
	price_year,
	ROUND(average_salary,2) AS avg_salary,
	ROUND(average_value,2) AS avg_food_price
FROM 
	primary_final_v4
GROUP BY 
	payroll_year, price_year;