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