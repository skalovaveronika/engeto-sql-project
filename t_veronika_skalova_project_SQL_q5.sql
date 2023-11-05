-- Q5 Base querry to retrieve economic data with average salary/food price data.
SELECT 
	sf.country,
	sf.economy_year, 
	sf.GDP_mil_dollars,
	ROUND(AVG(pf.average_salary),2) AS average_salary,
	pf.currency,
	ROUND(AVG(pf.average_value),2) AS average_food_price,
	pf.currency
FROM 
	primary_final_v4 pf
JOIN 
	secondary_final_v2 sf
ON 
	pf.payroll_year = sf.economy_year -- joined with years
GROUP BY 
	sf.economy_year;