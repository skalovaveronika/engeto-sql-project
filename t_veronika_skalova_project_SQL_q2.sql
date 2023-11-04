-- Q2 Base querry to extract data for milk and bread
SELECT *
FROM 
	primary_final_v4
WHERE 
	food_code IN ('114201', '111301') 