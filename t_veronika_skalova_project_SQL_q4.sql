-- Q4 Base querry to analyze the average salary and food prices over multiple years.
SELECT 
	payroll_year,
	ROUND(AVG(average_salary),2) AS avg_salary,
	price_year,
	ROUND(AVG(average_value),2) AS avg_food_price
FROM 
	primary_final_v4
GROUP BY 
	payroll_year, price_year;
	
-- Q4 CTE including percentual changes in salaries and price of food. 
WITH yearly_averages AS (
	SELECT 
		payroll_year,
		ROUND(AVG(average_salary),2) AS avg_salary,
		price_year,
		ROUND(AVG(average_value),2) AS avg_food_price
	FROM 
		primary_final_v4
	GROUP BY 
		payroll_year, price_year 
)
SELECT 
	Y.payroll_year,
	Y.avg_salary,
	ROUND(((Y.avg_salary - LAG(Y.avg_salary) OVER (ORDER BY Y.payroll_year)) / LAG(Y.avg_salary) OVER (ORDER BY Y.payroll_year)) * 100, 2) AS salary_change_percent,
	Y.price_year,
	Y.avg_food_price,
	ROUND(((Y.avg_food_price - LAG(Y.avg_food_price) OVER (ORDER BY Y.payroll_year)) / LAG(Y.avg_food_price) OVER (ORDER BY Y.payroll_year)) * 100, 2) AS food_change_percent
FROM 
	yearly_averages Y
LEFT JOIN
	yearly_averages P 
ON 
	Y.payroll_year = P.payroll_year + 1 -- left join on payroll YEAR
ORDER BY 
	Y.payroll_year;