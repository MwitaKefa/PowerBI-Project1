SELECT 
    genre, COUNT(*) AS number_of_games
FROM
    video_game_sales
GROUP BY genre
ORDER BY number_of_games DESC;

-- 2. Which year had the most game release?

SELECT 
	Year,count(*) as number_of_releases
FROM
	video_game_sales
GROUP BY Year
ORDER BY number_of_releases desc;

-- 3. Top 5 years games release by genre.
SELECT 
	Genre,Year,count(*) as number_of_releases
FROM
	video_game_sales
GROUP BY Year
ORDER BY number_of_releases desc
Limit 5;

SELECT 
    Genre,
    Year,
    number_of_releases
FROM (
    SELECT 
        Genre,
        Year,
        COUNT(*) AS number_of_releases,
        ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY COUNT(*) DESC) AS rn
    FROM
        video_game_sales
    GROUP BY Genre, Year
) AS ranked
WHERE rn <= 5
ORDER BY Genre, number_of_releases DESC;

-- 4. Which year had the highest sales worldwide?

SELECT 
    Year, ROUND(SUM(Global_Sales), 3) AS sum_of_sales
FROM
    video_game_sales
GROUP BY Year
ORDER BY sum_of_sales DESC;

-- 5. Which genre game has been released the most in a single year?

SELECT Genre, Year, Releases_count, ranking
FROM (
    SELECT 
        Genre, 
        Year, 
        COUNT(*) as Releases_count,
        ROW_NUMBER() OVER (PARTITION BY Year ORDER BY COUNT(*) DESC) as ranking
    FROM video_game_sales
    GROUP BY Year, Genre
) AS ranked_data
WHERE ranking <= 3 and year !=0
ORDER BY Year, Releases_count DESC;

-- 6. Which genre game has sold the most in a single year?

SELECT
    Year,
    Genre,
    ROUND(SUM(Global_Sales), 3) AS Total_Sales
FROM
    video_game_sales
GROUP BY
    Year, Genre
ORDER BY
    Total_Sales DESC
LIMIT 10;

-- 7. Which genre game have the highest sale price globally

SELECT 
    Genre, ROUND(SUM(Global_Sales), 3) AS sum_of_sales
FROM
    video_game_sales
GROUP BY Genre
ORDER BY sum_of_sales DESC;

-- 8. Which platfrom have the highest sale price globally

SELECT 
    Platform, ROUND(SUM(Global_Sales), 3) AS sum_of_sales
FROM
    video_game_sales
GROUP BY Platform
ORDER BY sum_of_sales DESC;

-- 9. Which individual game have the highest sale price globally?

SELECT 
    Name, ROUND(SUM(Global_Sales), 3) AS sum_of_sales
FROM
    video_game_sales
GROUP BY Name
ORDER BY sum_of_sales DESC;

-- 10. Sales compearison by genre

SELECT
    Genre,
    ROUND(SUM(Global_Sales),2)AS Global_Sales,
    ROUND(SUM(NA_Sales),2) AS NA_Sales,
    ROUND(SUM(EU_Sales),2) AS EU_Sales,
    ROUND(SUM(JP_Sales) ,2) AS JP_Sales,
    ROUND(SUM(Other_Sales),2)  AS Other_Sales
FROM
    video_game_sales
GROUP BY
    Genre
ORDER BY
    Global_Sales DESC;

-- 11. Sales compearison by platform

SELECT
    Platform,
    ROUND(SUM(Global_Sales),2)AS Global_Sales,
    ROUND(SUM(NA_Sales),2) AS NA_Sales,
    ROUND(SUM(EU_Sales),2) AS EU_Sales,
    ROUND(SUM(JP_Sales) ,2) AS JP_Sales,
    ROUND(SUM(Other_Sales),2)  AS Other_Sales
FROM
    video_game_sales
GROUP BY
    Platform
ORDER BY
    Global_Sales DESC;
    
-- 12. Top 20 Publisher

SELECT 
    Publisher, COUNT(*) AS Total_Publications
FROM
    video_game_sales
GROUP BY Publisher
ORDER BY Total_Publications DESC
LIMIT 20; 

-- 14. publisher comperison

SELECT
    Publisher,
    ROUND(SUM(Global_Sales),2)AS Global_Sales,
    ROUND(SUM(NA_Sales),2) AS NA_Sales,
    ROUND(SUM(EU_Sales),2) AS EU_Sales,
    ROUND(SUM(JP_Sales) ,2) AS JP_Sales,
    ROUND(SUM(Other_Sales),2)  AS Other_Sales
FROM
    video_game_sales
GROUP BY
    Publisher
ORDER BY
    Global_Sales DESC
LIMIT 10;

-- 15. Top publisher by Count each year
SELECT
    Year,
    Publisher,
    COUNT(*) AS Publications_count
FROM
    video_game_sales
GROUP BY
    Year, Publisher
ORDER BY
    Publications_count DESC;

-- 16. Total revenue by region

SELECT
    ROUND(SUM(Global_Sales),2)AS Global_Sales,
    ROUND(SUM(NA_Sales),2) AS NA_Sales,
    ROUND(SUM(EU_Sales),2) AS EU_Sales,
    ROUND(SUM(JP_Sales) ,2) AS JP_Sales,
    ROUND(SUM(Other_Sales),2)  AS Other_Sales
FROM video_game_sales;    
