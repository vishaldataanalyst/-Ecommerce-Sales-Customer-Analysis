/* 
Business Problem: E-Commerce Sales & Customer Analysis

Objective:
As a Junior Data Analyst at an e-commerce company, 
the goal is to analyze sales, products, and customer behavior to increase revenue, improve customer retention, 
and identify high-value customers.

Business Questions:

1. Top Products by Revenue:
   - Identify the top 10 products contributing the most to total revenue.
   - Detect underperforming products for potential promotions or removal.

2. High-Value Customers:
   - Identify top 10% of customers based on total spending.
   - Analyze repeat vs one-time buyers.
   - Segment customers based on spending patterns.

3. Monthly / Quarterly Sales Trends:
   - Analyze total revenue per month/quarter.
   

4. Customer Purchase Frequency:
   - Count total orders per customer.
   - Identify frequent buyers vs occasional buyers.

5. Regional Sales Performance:
   - Analyze revenue by customer region.
   - Determine which regions are most profitable.
   - Support marketing campaigns for targeted regions.

6. Product Associations & Cross-Sell Opportunities:
   - Identify products often bought together.
   - Recommend bundled promotions or cross-selling opportunities.

Outcome:
The analysis will help management make data-driven decisions on product focus, customer retention strategies, targeted marketing, and overall revenue optimization.
*/
create schema ecommerce;
use ecommerce;
CREATE TABLE ecommerce_orders (
    cid VARCHAR(20),
    tid VARCHAR(20),
    gender VARCHAR(10),
    age_group VARCHAR(20),
    purchase_date DATE,
    product_category VARCHAR(100),
    discount_availed VARCHAR(5),
    discount_name VARCHAR(100),
    discount_amount_inr FLOAT,
    gross_amount FLOAT,
    net_amount FLOAT,
    purchase_method VARCHAR(50),
    location VARCHAR(100)
);
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN cid IS NULL THEN 1 ELSE 0 END) AS cid_nulls,
    SUM(CASE WHEN tid IS NULL THEN 1 ELSE 0 END) AS tid_nulls,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_nulls,
    SUM(CASE WHEN age_group IS NULL THEN 1 ELSE 0 END) AS age_group_nulls,
    SUM(CASE WHEN purchase_date IS NULL THEN 1 ELSE 0 END) AS purchase_date_nulls,
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS product_category_nulls,
    SUM(CASE WHEN discount_availed IS NULL THEN 1 ELSE 0 END) AS discount_availed_nulls,
    SUM(CASE WHEN discount_name IS NULL THEN 1 ELSE 0 END) AS discount_name_nulls,
    SUM(CASE WHEN discount_amount_inr IS NULL THEN 1 ELSE 0 END) AS discount_amount_nulls,
    SUM(CASE WHEN gross_amount IS NULL THEN 1 ELSE 0 END) AS gross_amount_nulls,
    SUM(CASE WHEN net_amount IS NULL THEN 1 ELSE 0 END) AS net_amount_nulls,
    SUM(CASE WHEN purchase_method IS NULL THEN 1 ELSE 0 END) AS purchase_method_nulls,
    SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS location_nulls
FROM ecommerce_orders;
SELECT cid, tid, gender, age_group, purchase_date, product_category, discount_availed,
       discount_name, discount_amount_inr, gross_amount, net_amount, purchase_method, location,
       COUNT(*) AS duplicate_count
FROM ecommerce_orders
GROUP BY cid, tid, gender, age_group, purchase_date, product_category, discount_availed,
         discount_name, discount_amount_inr, gross_amount, net_amount, purchase_method, location
HAVING COUNT(*) > 1;
select count(*) from ecommerce_orders;
select * from ecommerce_orders limit 3;
select sum(net_amount) as Total_Sales from  ecommerce_orders;
-- Total Sales Amount Is '158177239'
select avg(net_amount) as Average_Sales from  ecommerce_orders;
-- Average sales price is '2875'
select count(tid) as Total_orders from  ecommerce_orders;
-- Total order is '55000'
select avg(discount_amount_inr) as Average_Discount from  ecommerce_orders;
-- Average Discount Per Order is '137'
select gender ,count(gender) as total_count_of_gender from ecommerce_orders group by gender;
/* Total no of gender is
Female	18454
Male	18096
Other	18450
*/
SELECT DATE_FORMAT(purchase_date, '%Y-%m') AS month, SUM(net_amount) AS monthly_sales
FROM ecommerce_orders
GROUP BY month
ORDER BY  month ;
/*
Top 2 Maximum Sales month is
'2021-12', '3711177'
'2023-12', '3900779.'
 */
SELECT location, COUNT(*) AS total_orders, SUM(net_amount) AS total_sales
FROM ecommerce_orders
GROUP BY location
ORDER BY total_sales DESC;
/* 
Top 3 Cities By Sales Are
Mumbai		32083841
Delhi		31098974
Bangalore	23619545
*/
SELECT discount_availed, COUNT(*) AS total_orders, SUM(discount_amount_inr) AS total_discount
FROM ecommerce_orders
GROUP BY discount_availed;
/* 
Total Discount Availed No and values
Yes	27415	7534273
No	27585	0
*/
SELECT purchase_method, COUNT(*) AS total_orders, SUM(net_amount) AS total_sales
FROM ecommerce_orders
GROUP BY purchase_method
order by SUM(net_amount) desc ;
/*  
Top 3 purches methode and valuse of purches
Credit Card	22096	63689354
Debit Card	13809	39770742
Net Banking	5485	15765768
*/
SELECT age_group, COUNT(*) AS total_orders, SUM(net_amount) AS total_sales
FROM ecommerce_orders
GROUP BY age_group
order by SUM(net_amount) desc ;
/* 
Top3 Age group Which Purchesed More Items And More In Amount
25-45	22010	63933310
18-25	16431	46804916
45-60	11104	31683799
*/
/* Business Insights
1.High-value customers are mostly 25–45 years old → focus marketing here.
2.Major cities (Mumbai, Delhi, Bangalore) drive most revenue → prioritize inventory, delivery, and promotions here.
3.Credit Card is the most popular payment method → potential for payment-based promotions.
4.Discounts are heavily used (~50% of orders) → effective in driving purchases but need ROI check.
5.Seasonality: December is a high-sales month → plan campaigns accordingly.*/

select * from ecommerce_orders limit 3;

-- 1. Top Products by Revenue:
  
   create view top_products_by_sales as
   select product_category , round(sum(net_amount),0) as top_products_by_sales from ecommerce_orders 
   group by   product_category
   order by sum(net_amount) desc 
   limit 10;
   select * from top_products_by_sales;
 -- Identify the top  products contributing the most to total revenue.
   /* Top 3 Products By revanue Are
   Electronics	47482568
Clothing	31220377
Beauty and Health	24185520
*/
   -- Detect underperforming products for potential promotions or removal.
   /* 2 Products Which Need To Promotion , Are 
   Pet Care	4637088
Toys & Games	4476831
*/
-- 2.  High-Value Customers:
   -- Identify top 10% of customers based on total spending.
CREATE VIEW Top_10_per_cust_by_spending AS
SELECT cid, total_spend
FROM (
    SELECT 
        cid,
        ROUND(SUM(net_amount), 0) AS total_spend,
        ROW_NUMBER() OVER (ORDER BY SUM(net_amount) DESC) AS rn,
        COUNT(*) OVER () AS total_customers
    FROM ecommerce_orders
    GROUP BY cid
) AS ranked
WHERE rn <= total_customers * 0.1;
select * from Top_10_per_cust_by_spending;
   -- Analyze repeat vs one-time buyers.
   create view Buyer_Type as
 SELECT 
    CASE 
        WHEN total_orders = 1 THEN 'One-Time Buyer'
        ELSE 'Repeat Buyer'
    END AS customer_type,
    COUNT(*) AS num_customers,
    round(SUM(total_spend),0) AS total_sales
FROM (
    SELECT cid, COUNT(tid) AS total_orders, round(SUM(net_amount),0) AS total_spend
    FROM ecommerce_orders
    GROUP BY cid
) AS customer_orders
GROUP BY customer_type;
select * from  Buyer_Type;
/* 
 Buyer wise total no of orders and total revanue
 Repeat Buyer	16073	120815936
One-Time Buyer	12998	37361357
 */
   -- Segment customers based on spending patterns.
   SELECT 
    spender_segment,
    COUNT(*) AS num_customers,
    ROUND(SUM(total_spend), 0) AS total_revenue
FROM (
    SELECT
        cid,
        ROUND(total_spend, 0) AS total_spend,
        CASE
            WHEN total_spend >= 5000 THEN 'High Spender'
            WHEN total_spend >= 2000 THEN 'Medium Spender'
            ELSE 'Low Spender'
        END AS spender_segment
    FROM (
        SELECT cid, SUM(net_amount) AS total_spend
        FROM ecommerce_orders
        GROUP BY cid
    ) AS customer_spend
) AS segmented
GROUP BY spender_segment;

/* Total spend by spender segment
Medium Spender		37240824
Low Spender		5501220
High Spender		115435249 */
select * from ecommerce_orders limit 3;
-- 3. Monthly / Quarterly Sales Trends:
   -- Analyze total revenue per month/quarter.
   create view Month_wise_Revenue as
   
   SELECT 
    DATE_FORMAT(purchase_date, '%Y-%m') AS month,
    ROUND(SUM(net_amount), 0) AS total_revenue
FROM ecommerce_orders
GROUP BY month
ORDER BY month;
select * from  Month_wise_Revenue;
-- 4. Customer Purchase Frequency:
   -- Count total orders per customer.
   --   -- Identify frequent buyers vs occasional buyers.
   create view Total_order_per_cust as
 SELECT 
    cid,
    COUNT(tid) AS total_orders,
    CASE 
        WHEN COUNT(tid) >= 6 THEN 'Frequent Buyer'
        WHEN COUNT(tid) >= 4 THEN 'Medium Buyer'
        ELSE 'Occasional Buyer'
    END AS buyer_segment
FROM ecommerce_orders
GROUP BY cid
ORDER BY total_orders DESC;
select * from Total_order_per_cust;

-- 5. Regional Sales Performance:
   -- Analyze revenue by customer region.
   -- Determine which regions are most profitable.
   -- Support marketing campaigns for targeted regions.
   create view Revenue_By_Region as
  select location ,round(sum(net_amount),0) as Total_revenue from ecommerce_orders group by location order by Total_revenue desc;
  select * from Revenue_By_Region;
  /* 
   Top 3 Region By Revenue are
   Mumbai	32083841
Delhi	31098975
Bangalore	23619546

Metro cities contribute the majority of total revenue → strong purchasing power and digital adoption.

Bottom Top Region By Revenue

Varanasi	1744066
Srinagar	1585927
Dehradun	1569219

These regions may need:
Local promotions
Logistics optimization
Regional marketing campaigns
*/
-- 6. Product Associations & Cross-Sell Opportunities:
   -- Identify products often bought together.
   -- Recommend bundled promotions or cross-selling opportunities.
select distinct(product_category) from ecommerce_orders;
create view cross_sell_products as
SELECT 
    a.product_category AS base_product,
    b.product_category AS cross_sell_product,
    ROUND(SUM(b.net_amount),0) AS cross_sell_revenue
FROM ecommerce_orders a
JOIN ecommerce_orders b
    ON a.cid = b.cid
   AND a.product_category <> b.product_category
GROUP BY base_product, cross_sell_product
ORDER BY cross_sell_revenue DESC;
select * from cross_sell_products;
/*
Insight 1 – Electronics is the Anchor Category
Electronics appears in almost every top cross-sell pair, acting as a revenue magnet.
Insight 2 – Lifestyle Clusters Exist
Clothing + Beauty + Sports = Lifestyle Cluster
Electronics + Home = Utility Cluster
Insight 3 – Symmetry Confirms Reliability
Example:
Clothing → Electronics ≈ Electronics → Clothing
This symmetry proves data consistency and real behavior.*/

-- TOP PRODUCTS & CATEGORY PERFORMANCE
/* Recommendation:
1. Electronics, Clothing, and Beauty contribute ~64% of total revenue.
2. Prioritize inventory availability, pricing optimization, and promotions for these categories.
3. Underperforming categories (Pet Care, Toys & Games) should be tested with targeted discounts or bundled offers before considering removal.
4. Allocate higher marketing budget to top-performing categories to maximize ROI.
*/

-- HIGH-VALUE CUSTOMERS (TOP 10%)
/* Recommendation:
1. Top 10% customers contribute a disproportionately high share of revenue.
2. Create VIP programs (exclusive discounts, early access, priority delivery) for these customers.
3. Protect this segment through proactive retention strategies to prevent revenue loss.
4. Track churn risk for high-value customers separately.
*/

-- REPEAT vs ONE-TIME BUYERS
/* Recommendation:
1. Repeat buyers contribute ~76% of total revenue, proving retention is more profitable than acquisition.
2. Increase focus on repeat purchase incentives (loyalty points, personalized offers).
3. Reduce dependency on one-time buyers by encouraging second purchase journeys.
*/

-- CUSTOMER SEGMENTATION (SPENDER + FREQUENCY)
/* Recommendation:
1. High spenders generate the majority of revenue and should receive premium engagement.
2. Medium spenders show potential for upsell through personalized recommendations.
3. Occasional buyers (low-frequency but high-volume) should be targeted with first-repeat discounts to increase purchase frequency.
4. Segment-based marketing campaigns will be more effective than generic promotions.
*/

-- SEASONAL SALES TRENDS (MONTHLY / QUARTERLY)
/* Recommendation:
1. Sales peak during November–December, indicating strong festive season demand.
2. Increase inventory stocking, marketing spend, and logistics capacity from August onward.
3. Run pre-festive teaser campaigns to capture early demand.
*/

-- REGIONAL PERFORMANCE
/* Recommendation:
1. Metro cities (Mumbai, Delhi, Bangalore) contribute ~55% of total revenue.
2. Strengthen logistics, faster delivery, and city-specific campaigns in these regions.
3. Low-performing regions (Varanasi, Srinagar, Dehradun) require localized promotions or operational optimization.
4. Pilot targeted campaigns in Tier-2 cities to diversify revenue risk.
*/

-- DISCOUNT STRATEGY
/* Recommendation:
1. Discounts are used in ~50% of orders, indicating high price sensitivity.
2. Evaluate discount ROI to ensure profitability is not compromised.
3. Replace flat discounts with targeted or conditional discounts (cart value, repeat users).
*/

-- CROSS-SELL & BUNDLING OPPORTUNITIES (VERY STRONG)
/* Recommendation:
1. Electronics acts as an anchor category in cross-sell behavior.
2. Introduce bundles such as:
   - Electronics + Home
   - Clothing + Beauty
3. Display cross-sell recommendations on product and checkout pages.
4. Bundled offers can increase Average Order Value (AOV).
*/