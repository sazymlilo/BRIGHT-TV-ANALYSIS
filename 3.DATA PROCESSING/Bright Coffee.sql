-- Databricks notebook source
--------------------------------------------checking full table
SELECT * FROM `workspace`.`default`.`bright_coffee_shop`;

----------------------------------------checking row/duplicates, number of row= number of unique tran_id = no duplicates
SELECT COUNT(*) AS num_rows,
       COUNT(DISTINCT transaction_id) AS user_id
FROM `workspace`.`default`.`bright_coffee_shop`;

--------------------------------------------checking NULLs in some of the columns of the dataset
SELECT COUNT(*) AS null_count
FROM `workspace`.`default`.`bright_coffee_shop`
WHERE transaction_id IS NULL OR transaction_date IS NULL OR transaction_time IS NULL OR transaction_qty IS NULL OR store_id IS NULL OR store_location IS NULL OR product_id IS NULL OR unit_price IS NULL OR product_category IS NULL OR product_type IS NULL OR product_detail IS NULL;


select sum(transaction_qty* unit_price) AS total_revenue from `workspace`.`default`.`bright_coffee_shop`;

SELECT SUM(transaction_qty * TRY_CAST(REPLACE(unit_price, ',', '.') AS DOUBLE)) AS Total_Revenue
FROM `workspace`.`default`.`bright_coffee_shop`;

select MIN(unit_price) AS lowest_price,
      MAX(unit_price) AS highest_price,
      AVG(unit_price) AS avg_price
      FROM `workspace`.`default`.`bright_coffee_shop`;


SELECT DISTINCT store_location,
        ROUND(SUM(transaction_qty * TRY_CAST(REPLACE(unit_price, ',','.') AS DOUBLE)),2) AS Total_Revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY store_location
ORDER BY Total_Revenue;


SELECT store_location,
       SUM(transaction_qty * unit_price) AS total_revenue
FROM `workspace`.`default`.`bright_coffee_shop`
GROUP BY store_location
ORDER BY total_revenue;


SELECT AVG(transaction_qty) AS AVG_transactions
FROM `workspace`.`default`.`bright_coffee_shop`;


BIG CLEANED DATA QUERY

select transaction_id,
transaction_date, 

transaction_time,
       transaction_qty,
       store_id,
       store_location,
       product_id,
       unit_price,
       product_category,
       product_type,
       product_detail

       
select sum(transaction_qty* unit_price) AS total_revenue 
       

       select

      DAY NAME(transaction_date) AS day_name
        Hour(transaction_time) AS transaction_hour
        DAYWEEK(transaction_date) AS day_of_week
        MONTHNAME(transaction_date) AS month_name
        DATE_FORMAT(transaction_date, HH:mm:ss) AS 
        YEAR(transaction_date)


        SELECT CASE
      WHEN HOUR (transaction_time)  BETWEEN 0 AND 2 THEN 'wee hours'
                                            BETWEEN 3 and 5 THEN 'dawn hours'
                                            BETWEEN 6 and 8 THEN 'early_morning'
                                            BETWEEN 9 and 11 THEN 'morning'
                                            BETWEEN 12 and 14 THEN 'afternoon'
                                            BETWEEN 15 and 17 THEN 'late_afternoon'
                                            BETWEEN 18 and 20 THEN 'evening'
                                            BETWEEN 21


SELECT
    transaction_id,
    total_amount,
    CASE
        WHEN total_amount >= 500 THEN 'High Sale'
        WHEN total_amount >= 200 THEN 'Medium Sale'
        ELSE 'Low Sale'
    END AS sales_category
FROM bright_coffee_shop_sales


CASE

        WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(transaction_time) BETWEEN 17 AND 21 THEN 'Evening'
        ELSE 'Night'
        END AS Time_Bucket

CASE
        WHEN DAYOFWEEK(transaction_date) IN (1,7)
        THEN 'Weekend'
        ELSE 'Weekday'
        END AS Day_Type,

SELECT
     transaction_time,
    CASE
        WHEN HOUR(transaction_time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(transaction_time) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(transaction_time) BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS time_of_day
FROM bright_coffee



      select*from `workspace``.`default`.`bright_coffee_shop`;

