-- Q3 Base querry - created to analyze food price trends by adding a 'previous_year_value' column.
SELECT 
	price_year,
	food_code,
	food_type,
	average_value,
	LAG(average_value) OVER (PARTITION BY food_code, food_type ORDER BY price_year) AS previous_year_value
FROM 
	primary_final_v4
GROUP BY 
	food_code, food_type, price_year;

-- Q3 in progress
WITH food_price_changes AS (
	SELECT 
		price_year,
		food_code,
		food_type,
		average_value,
		LAG(average_value) OVER (PARTITION BY food_code, food_type ORDER BY price_year) AS previous_year_value
	FROM 
		primary_final_v4
	GROUP BY 
		food_code, food_type, price_year
)
SELECT 
	food_code,
	food_type,
	MIN(ROUND((average_value - previous_year_value) / previous_year_value * 100, 2)) AS lowest_increase
FROM 
	food_price_changes
GROUP BY
	food_code, food_type
ORDER BY
	lowest_increase
