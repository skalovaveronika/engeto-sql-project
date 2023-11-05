-- Q4 Base querry to analyze the average salary and food prices over multiple years.
SELECT 
	payroll_year,
	price_year,
	ROUND(AVG(average_salary),2) AS avg_salary,
	ROUND(AVG(average_value),2) AS avg_food_price
FROM 
	primary_final_v4
GROUP BY 
	payroll_year, price_year;