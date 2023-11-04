SELECT 
	id, 
	value, 
	category_code,
	YEAR(date_from) AS year_from,
	YEAR(date_to) AS year_to,
    region_code
FROM 
	czechia_price cp
WHERE 
	category_code IN ('114201', '111301')
	AND YEAR(date_from) = YEAR(date_to);