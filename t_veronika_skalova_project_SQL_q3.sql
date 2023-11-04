/* Q3 Base querry - created to analyze food price trends by adding a 'previous_year_value' column. 
It is based on the 'average_value,' which represents the average yearly price across all food categories.*/
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

/* Q3: Final querry to identify the food category with the slowest price increase. 
The 'lowest_increase' column is calculated as the minimum percentage increase in prices across all food categories.
The result is grouped by food code and food type and ordered in ascending order to determine the lowest price increase.
*/
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
LIMIT 1;


-- Q3 AUX Querry for '117101' food code
SELECT 
    price_year,
    food_code,
    food_type,
    average_value AS average_price
FROM 
    primary_final_v4
WHERE 
	food_code = 117101
GROUP BY 
    price_year, food_code, food_type
ORDER BY 
    price_year;
