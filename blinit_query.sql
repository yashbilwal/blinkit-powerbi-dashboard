show databases;
use blinkitdb;
show tables;
desc blinkit_data;
ALTER TABLE blinkit_data
MODIFY COLUMN `Rating` float;

SELECT * FROM blinkit_data;

SELECT COUNT(*) FROM blinkit_data;

SELECT DISTINCT `Item Fat Content` 
FROM blinkit_data;

UPDATE blinkit_data
SET `Item Fat Content` = 
CASE 
WHEN `Item Fat Content` IN ('LF', 'low fat') THEN 'Low Fat'
WHEN `Item Fat Content` = 'reg' THEN 'Regular'
ELSE `Item Fat Content`
END;

desc blinkit_data;

SELECT CONCAT(CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)), ' Millions') AS Total_Sales
FROM blinkit_data
WHERE `Item Fat Content` = 'Low Fat';

SELECT CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales 
FROM blinkit_data;

SELECT COUNT(*) AS No_Of_Items FROM blinkit_data;

SELECT CAST(AVG(Rating)AS DECIMAL(10,2)) AS AVG_Rating 
FROM blinkit_data;

SELECT `Item Fat Content`, 
		CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)), 'k') AS Total_Sales_Thousands,
		CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
        CAST(AVG(Rating)AS DECIMAL(10,2)) AS AVG_Rating,
        COUNT(*) AS No_Of_Items
FROM blinkit_data
WHERE `Outlet Establishment Year` = 2022
GROUP BY `Item Fat Content`
ORDER BY `Total_Sales_Thousands` DESC;

SELECT `Item Type`, 
		CONCAT(CAST(SUM(Sales) AS DECIMAL(10,2)), 'k') AS Total_Sales,
		CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
        CAST(AVG(Rating)AS DECIMAL(10,2)) AS AVG_Rating,
        COUNT(*) AS No_Of_Items
FROM blinkit_data
GROUP BY `Item Type`
ORDER BY `Total_Sales` DESC
LIMIT 5;


-- SELECT `Outlet Location Type`,
-- 		ISNULL([Low Fat], 0) AS Low_Fat,
--         ISNULL([Regular], 0) AS Regular
-- FROM 
-- (
-- 		SELECT `Outlet Location Type`, `Item Fat Content`, CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
--         FROM blinkit_data
--         GROUP BY `Outlet Location Type`, `Item Fat Content` As SourceTable
-- 	PIVOT
--     (
-- 		SUM(Total_Sales)
--         FOR `Item Fat Content` IN ([Low Fat], [Regular])
--     ) AS PivotTable
--       ORDER BY `Outlet Location Type`
-- ); 1:

SELECT 
    `Outlet Location Type`,
    CAST(SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN Sales ELSE 0 END) AS DECIMAL(10,2)) AS Low_Fat,
    CAST(SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN Sales ELSE 0 END) AS DECIMAL(10,2)) AS Regular
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;


SELECT 
    `Outlet Establishment Year`,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
    COUNT(*) AS No_Of_Items
FROM blinkit_data
GROUP BY `Outlet Establishment Year`
ORDER BY `Total_Sales` DESC;

-- percentage of sales by outlet size

SELECT
	`Outlet Size`,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY `Outlet Size`
ORDER BY `Total_Sales` DESC;


-- Slaes by outlet location

SELECT 
    `Outlet Location Type`,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
    COUNT(*) AS No_Of_Items
FROM blinkit_data
WHERE `Outlet Establishment Year` = 2020
GROUP BY `Outlet Location Type`
ORDER BY `Total_Sales` DESC;


-- All metrics by outlet type

SELECT 
    `Outlet Type`,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
    COUNT(*) AS No_Of_Items
FROM blinkit_data
GROUP BY `Outlet Type`
ORDER BY `Total_Sales` DESC;

-- 1:48
