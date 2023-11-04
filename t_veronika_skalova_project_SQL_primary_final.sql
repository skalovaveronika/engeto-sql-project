-- Rows count to determine where the years in 'date_from' and 'date_to' columns match. The result matches the original row count in czechia_price table. 
SELECT 
	COUNT(*) AS matching_rows
FROM 
	czechia_price cp
WHERE 
	YEAR(date_from) = YEAR(date_to);

-- View created to calculate the average price in Czechia by year to reduce row count. 
CREATE VIEW czechia_price_avg_by_yr AS
SELECT 
	YEAR(date_from) AS price_year,
	category_code,
	ROUND(AVG(value),2) AS average_value
FROM 
	czechia_price cp
GROUP BY 
	YEAR(date_from), category_code
ORDER BY
	price_year, category_code;

-- View created to calculate the average payroll in Czechia by year to reduce row count; added WHERE conditions to filter out NULL values and unwanted value_type_code.
CREATE VIEW czechia_payroll_avg_by_yr_v2 AS
SELECT 
	payroll_year,
	industry_branch_code AS industry_code,
	ROUND(AVG(value),2) AS average_salary,
	unit_code AS currency
FROM 
	czechia_payroll cp 
WHERE 
	cp.value IS NOT NULL
	AND cp.value_type_code <> 316
	AND cp.industry_branch_code IS NOT NULL
GROUP BY 
	payroll_year, industry_code
ORDER BY
	payroll_year, industry_code;

/* View created to combine payroll, industry, and food price data for analysis.
Data joined from 'czechia_payroll_avg_by_yr_v2', 'czechia_payroll_unit', 'czechia_payroll_industry_branch', 'czechia_price_avg_by_yr', and 'czechia_price_category' to get necessary data for upcoming querries.
Results ordered by payroll year, industry code, and food category code.
*/
CREATE VIEW primary_final_v4 AS 
SELECT 
	cpaby.payroll_year,
	cpaby.industry_code,
	cpib.name AS industry_name,
	cpaby.average_salary,
	cpu.name AS currency,
	cpaby2.price_year,
	cpaby2.category_code AS food_code,
	cpr.name AS food_type,
	cpaby2.average_value,
	cpr.price_value AS food_quantity,
	cpr.price_unit AS measure_unit
FROM 
	czechia_payroll_avg_by_yr_v2 cpaby
JOIN
	czechia_payroll_unit cpu 
ON
	cpaby.currency = cpu.code 
JOIN
	czechia_payroll_industry_branch cpib 
ON
	cpaby.industry_code = cpib.code 
JOIN
	czechia_price_avg_by_yr cpaby2 
ON 
	cpaby.payroll_year = cpaby2.price_year 
JOIN 
	czechia_price_category cpr 
ON 
	cpaby2.category_code = cpr.code 
ORDER BY 
	cpaby.payroll_year, cpaby.industry_code, cpaby2.category_code;  


