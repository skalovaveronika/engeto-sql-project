/*  View created to extract economic data for 'Czech Republic.'
It combines data from the 'countries' and 'economies' tables to show the GDP in millions of dollars, population, and GINI index by year.*/
CREATE VIEW secondary_final_v2 AS 
SELECT 
	c.country AS country,
	e.YEAR AS economy_year,
	round( e.GDP / 1000000, 2 ) as GDP_mil_dollars,
	e.population,
	e.gini AS GINI_index
FROM 
	countries c 
JOIN 
	economies e 
ON 
	c.country = e.country -- join with countries
WHERE 
	c.country = 'Czech Republic'
GROUP BY 
	c.country, e.YEAR;
    