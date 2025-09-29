Create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

-- data exploration

-- count of rows
SELECT COUNT(*) FROM zepto;

-- sample data
SELECT * FROM zepto
LIMIT 10;

-- null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountsellingprice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

-- Different product category
SELECT DISTINCT category FROM zepto ORDER BY category;

-- products in stock vs out of stock
SELECT OUToFStock , count(sku_id) from Zepto GROUP BY OutOfStock;

-- products names present multiple times
SELECT name,count(sku_id) as "number of skus" from zepto GROUP BY name HAVING COUNT(Sku_id)>1 ORDER BY COUNT(Sku_id) DESC;

-- DAta cleaning

-- products with price =0

SELECT * FROM zepto WHERE mrp = 0 OR discountsellingprice = 0;
SELECT * FROM zepto limit 20;
SELECT mrp,discountsellingprice FROM zepto;

-- Q1 find the top 10 best value products based on the discount percentage.
SELECT DISTINCT name,mrp,discountpercent FROM zepto
ORDER BY discountpercent DESC LIMIT 10;

-- Q2 What r the proudts with high mrp but out of stock
SELECT DISTINCT name,mrp FROM zepto
WHERE outofStock = TRUE and mrp > 300
ORDER BY mrp DESC;

-- q3 calculate estimated revenue for each category
SELECT category,SUM(discountsellingprice * availableQuantity) As total_revenue
from zepto
group by category order by total_revenue;

-- q4 find all proudts where mrp is greater than 500 and discount is less than 10%
SELECT DISTINCT name,mrp,discountpercent from zepto
where mrp > 500 AND discountpercent < 10
ORDER BY mrp DESC, discountpercent DESC;

-- Q5 IDENTIFY  the top 5 categories offering the highest average discount percentage
SELECT category ,
ROUND(AVG(discountpercent),2) AS avg_discount from zepto
GROUP BY category
ORDER BY avg_discount DESC LIMIT 5;

-- q6  find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name,weightInGms,discountsellingprice,ROUND(discountsellingprice/weightInGms,2) AS price_per_gram
FROM zepto 
WHERE weightInGms >=100
ORDER BY price_per_gram;

-- q7 group the products into categories like low ,medium and bulk
SELECT DISTINCT name,weightInGms,
CASE WHEN weightInGms <1000 THEN 'low'
WHEN weightInGms <5000 THEN 'medium'
else 'bulk'
END AS weight_category FROM zepto;

-- q8 what is the total inventory weight per category
SELECT category,SUM(weightInGms * availablequantity) AS total_weight from zepto
GROUP BY category ORDER BY total_weight;