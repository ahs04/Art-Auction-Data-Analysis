-- Basic Exploration

-- Getting Started
SELECT * FROM cleanedtransactions
LIMIT 20;

-- Insight on Prices in General
SELECT 
    MIN(price_usd) AS min_price,
    MAX(price_usd) AS max_price,
    ROUND(AVG(price_usd),2) AS avg_price,
    COUNT(price_usd) AS number_of_prices
FROM cleanedtransactions;

-- Artworks by Year
SELECT 
    event_year,
    COUNT(*) AS total_artworks
FROM cleanedtransactions
GROUP BY event_year
ORDER BY event_year;

-- First Question Analysis: What genres of art has been rising within the past few years?

-- Overview of Genres
SELECT 
    genre,
    COUNT(*) AS total_artworks,
    ROUND(AVG(price_usd),2) AS avg_price,
	SUM(price_usd) AS total_tevenue
FROM cleanedtransactions
GROUP BY genre
ORDER BY total_artworks DESC;

-- Yearly Distribution of Genres
SELECT 
    genre,
    event_year,
    COUNT(*) AS total_artworks,
	SUM(price_usd) AS total_cost,
	ROUND(AVG(price_usd),2) AS avg_cost
FROM cleanedtransactions
GROUP BY genre, event_year
ORDER BY genre, event_year;


-- Second Question Analysis: What regions should we focus on for art auction trends?

-- Overview of regions
SELECT 
    country_or_city,
    COUNT(*) AS total_auctions,
    SUM(price_usd) AS total_revenue,
    ROUND(AVG(price_usd),2) AS avg_price
FROM cleanedtransactions
GROUP BY country_or_city
ORDER BY total_auctions DESC;


-- Regions based on revenue by year
SELECT 
    country_or_city,
    event_year,
    COUNT(*) AS total_auctions,
    SUM(price_usd) AS total_revenue
FROM cleanedtransactions
GROUP BY country_or_city, event_year
ORDER BY country_or_city, event_year;


-- Detailed Info on Region Specific Info by year and genre
SELECT 
    country_or_city,
    genre,
    COUNT(*) AS total_auctions,
    SUM(price_usd) AS total_revenue,
    ROUND(AVG(price_usd),2) AS avg_price
FROM cleanedtransactions
WHERE genre IS NOT NULL
GROUP BY country_or_city, genre
ORDER BY country_or_city, total_revenue DESC;


-- Where are auctions being held mostly?
SELECT
	country_or_city,
	COUNT(DISTINCT event_date) AS total_days,
	COUNT(*) AS total_auctions_in_region,
	ROUND(AVG(price_usd), 2) AS avg_price,
	SUM(price_usd) AS total_revenue
FROM cleanedtransactions
GROUP BY country_or_city

-- Third Question Analysis: Is there a correlation between different auction houses and revenue?

-- Overview of Revenue by Auction House
SELECT 
    auction_house,
    COUNT(*) AS total_auctions,
    SUM(price_usd) AS total_revenue,
    ROUND(AVG(price_usd),2) AS avg_price
FROM cleanedtransactions
GROUP BY auction_house
ORDER BY total_revenue DESC;

-- Number of Auction Transcations by Auction House
SELECT
	auction_house,
	COUNT(*) AS total_pieces
FROM cleanedtransactions
GROUP BY auction_house

-- Yearly Revenue by Auction House
SELECT 
    auction_house,
    event_year,
    SUM(price_usd) AS yearly_revenue
FROM cleanedtransactions
GROUP BY auction_house, event_year
ORDER BY auction_house, event_year;

-- Auction House Performance by Genre
SELECT 
    auction_house,
    genre,
    SUM(price_usd) AS total_revenue,
    ROUND(AVG(price_usd), 2) AS avg_price
FROM cleanedtransactions
GROUP BY auction_house, genre
ORDER BY auction_house, total_revenue DESC;

-- Top Auction Houses Over Time
WITH yearly_rankings AS 
(SELECT 
	auction_house,
	event_year,
	SUM(price_usd) AS yearly_revenue,
	RANK() OVER(PARTITION BY event_year ORDER BY(SUM(price_usd)) DESC) AS rank
FROM cleanedtransactions
GROUP BY auction_house, event_year)

SELECT * FROM yearly_rankings
WHERE rank <= 5
ORDER BY event_year;




-- Optional: Does having a biography lead to bigger sales in general?
SELECT
	biography,
	COUNT(*) AS total_artworks,
	ROUND(AVG(price_usd),2) AS avg_price
FROM cleanedtransactions
GROUP BY biography
ORDER BY total_artworks DESC;

