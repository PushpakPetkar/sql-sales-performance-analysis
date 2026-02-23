-- Total Revenue by Month
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY month
ORDER BY month;

-- Top 10 Products by Revenue
SELECT 
    product_name,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Region-wise Performance
SELECT 
    region,
    SUM(revenue) AS total_revenue
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;
