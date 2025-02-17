-- DELETE *cpi*, *real_price_usd*, *ln_real_price*, *price_eur*, and *price_gbp* THEN Run the Code Below

WITH filterTable AS 
(SELECT * FROM mytable
WHERE 
	country_or_city IS NOT NULL AND 
	event_name IS NOT NULL)

SELECT * FROM filterTable 
WHERE 
	bidding_currency IS NOT NULL AND
	currency IS NOT NULL AND
	ham_prem IS NOT NULL AND
	estimate_min IS NOT NULL AND
	estimate_max IS NOT NULL
	