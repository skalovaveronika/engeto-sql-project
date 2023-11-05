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
	
-- Q5 - A view created for percentual yearly averages for GDP, salary and food price. 
CREATE VIEW yearly_averages_view AS
WITH yearly_averages AS (
	SELECT 
		sf.country,
		sf.economy_year, 
		sf.GDP_mil_dollars,
		ROUND(AVG(pf.average_salary),2) AS average_salary,
		ROUND(AVG(pf.average_value),2) AS average_food_price
	FROM 
		primary_final_v4 pf
	JOIN 
		secondary_final_v2 sf
	ON 
		pf.payroll_year = sf.economy_year 
	GROUP BY 
		sf.economy_year
)
SELECT
	country,
	economy_year,
 	GDP_mil_dollars,
	ROUND((GDP_mil_dollars - LAG(GDP_mil_dollars) OVER (ORDER BY economy_year)) / LAG(GDP_mil_dollars) OVER (ORDER BY economy_year) * 100,2) AS GDP_change_percent,
	ROUND((average_salary - LAG(average_salary) OVER (ORDER BY economy_year)) / LAG(average_salary) OVER (ORDER BY economy_year) * 100,2) AS salary_change_percent,
	ROUND((average_food_price - LAG(average_food_price) OVER (ORDER BY economy_year)) / LAG(average_food_price) OVER (ORDER BY economy_year) * 100,2) AS food_price_change_percent
FROM
    yearly_averages;
   
-- Q5 - Correlation analysis between GDP, salary and food price. 
WITH gdp_correlation AS (
	SELECT
		AVG(GDP_change_percent) AS avg_gdp_change,
		AVG(salary_change_percent) AS avg_salary_change,
		AVG(food_price_change_percent) AS avg_food_price_change,
		COUNT(*) AS n
	FROM yearly_averages_view
)
SELECT
	ROUND((SUM((GDP_change_percent - avg_gdp_change) * (salary_change_percent - avg_salary_change)) / (n * STDDEV_POP(GDP_change_percent) * STDDEV_POP(salary_change_percent))),2) AS corr_gdp_salary,
	ROUND((SUM((GDP_change_percent - avg_gdp_change) * (food_price_change_percent - avg_food_price_change)) / (n * STDDEV_POP(GDP_change_percent) * STDDEV_POP(food_price_change_percent))),2) AS corr_gdp_food_price
FROM 
	yearly_averages_view
CROSS JOIN 
	gdp_correlation;

  