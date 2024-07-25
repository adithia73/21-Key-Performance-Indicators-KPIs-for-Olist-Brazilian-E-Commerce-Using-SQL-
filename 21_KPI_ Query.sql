/*# Analytics KPI -01: percentage distribution of customers in each state.*/

SELECT 
    customer_state,
    CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM olist_customers_dataset), 2), ' %') AS percentage
FROM 
    olist_customers_dataset 
GROUP BY 
    customer_state
order by 
    COUNT(*) desc;

/*#Analytics KPI - 02: Order Rate per date.*/
SELECT 
    DATE(order_purchase_timestamp) AS order_date,
    COUNT(order_id) AS order_count,
    CONCAT(ROUND(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM olist_orders_dataset), 2), ' %') AS order_rate_percentage
FROM 
    olist_orders_dataset
GROUP BY 
    DATE(order_purchase_timestamp)
ORDER BY 
    order_rate_percentage desc;
    

/* # Analytics KPI - 03 Cancellation Rate*/
SELECT 
	date(order_purchase_timestamp) as order_date,
    CONCAT(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM olist_orders_dataset), ' %') AS cancellation_rate
FROM 
    olist_orders_dataset
WHERE 
    order_status = 'canceled'
GROUP BY 
    order_date
order by 
	cancellation_rate desc;

/* #Analytics KPI - 04: Delivery Rate*/
SELECT 
	date(order_purchase_timestamp) as order_date,
    CONCAT(ROUND(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM olist_orders_dataset), 2), ' %') AS delivery_rate
FROM 
    olist_orders_dataset
WHERE 
    order_status = 'delivered'
GROUP BY 
    order_date
order by 
	delivery_rate desc;

/* #Analytics KPI – 05: Average Delivery Rate. */
SELECT date(order_purchase_timestamp) as order_date,
    AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS average_delivery_time
FROM 
    olist_orders_dataset
WHERE 
    order_delivered_customer_date IS NOT NULL
group by 
order_date
order by 
 average_delivery_time DESC;

/* #Analytics KPI – 06: Total Order Value based on order date.*/
SELECT 
date(order_purchase_timestamp) as order_date,
round(sum((price)),2) AS total_order_value
FROM 
olist_order_items_dataset as tb1
left join olist_orders_dataset as tb2 
on tb1.order_id=tb2.order_id
group by 
order_date
order by 
total_order_value desc;

/* # Analytics KPI – 07 Items Per Order. */
SELECT 
    date(order_purchase_timestamp) as order_date, avg(item_count) AS avg_items_per_order
FROM 
    olist_orders_dataset as tb1
left join 
	(SELECT order_id, COUNT(order_item_id) AS item_count
    From
      olist_order_items_dataset
    GROUP BY 
    order_id) tb2 on tb1.order_id=tb2.order_id
GROUP BY 
    order_date
ORDER BY
order_date asc;

/* #Analytics KPI – 08 Average Product Price per order.*/
SELECT 
tb2.order_id,
round(avg(price),2) AS average_product_price,date(order_purchase_timestamp) as order_date
FROM 
olist_order_items_dataset as tb1
left join olist_orders_dataset as tb2 
on tb1.order_id=tb2.order_id
group by 
tb2.order_id
order by
order_date asc;

/* #Analytics KPI – 09 Highest Category Sales Value. */

  SELECT 
product_category_name, round(SUM(price)) AS total_sales
FROM 
olist_order_items_dataset oi
JOIN 
olist_products_dataset op ON oi.product_id = op.product_id
GROUP BY 
product_category_name
ORDER BY 
total_sales DESC;

/* #Analytics KPI – 10 Average Freight Value Per Order. */
SELECT order_id,
    AVG(freight_value) AS average_freight_value
FROM 
    olist_order_items_dataset
group by 1;

SELECT 
date(order_purchase_timestamp) as order_date,
tb2.order_id,
AVG(freight_value) AS average_freight_value, avg(price) as avg_price
FROM 
olist_order_items_dataset as tb1
left join olist_orders_dataset as tb2 
on tb1.order_id=tb2.order_id
group by 
tb2.order_id 
order by 
average_freight_value desc;

/*# Analytics KPI – 11 Common Payment Type. */
SELECT 
    payment_type, COUNT(*) AS count
FROM 
    olist_order_payments_dataset
GROUP BY 
    payment_type
ORDER BY 
    count DESC;

/*#Analytics KPI – 12 Payment Value Per Order.*/
SELECT
    tb_1.order_id,
    SUM(tb_1.payment_value) AS total_payment_value,
    DATE(tb_2.order_purchase_timestamp) AS order_date
FROM
    olist_order_payments_dataset AS tb_1
INNER JOIN
    olist_orders_dataset AS tb_2
    ON tb_1.order_id = tb_2.order_id
GROUP BY
    tb_1.order_id
ORDER BY
    total_payment_value asc;


/*# Analytics KPI – 13 Average Installment Payment Value.*/
SELECT tb2.order_purchase_timestamp,customer_id ,tb2.order_id,tb4.product_category_name, AVG(payment_value / payment_installments) AS average_installment_value
 FROM olist_order_payments_dataset as tb1 
 left join olist_orders_dataset as tb2 on tb1.order_id=tb2.order_id
left join  olist_order_items_dataset as tb3 on tb2.order_id=tb3.order_id
left join olist_products_dataset as tb4 on tb3.product_id=tb4.product_id
group by 
tb2.order_id 
order by 
average_installment_value desc; 

# Analytics KPI – 14 Distribution of Product Categories.
SELECT 
    product_category_name, COUNT(*) AS count
FROM 
    olist_products_dataset
GROUP BY 
    product_category_name
ORDER BY 
    count DESC; 

/*# Analytics KPI - 15 Average Price Of Products In Each Category*/
SELECT 
    product_category_name, round(AVG(price),2) AS average_price ,count(product_category_name) as count_product_category_ordered
FROM 
    olist_order_items_dataset tb1
JOIN 
    olist_products_dataset tb2 ON tb1.product_id = tb2.product_id
GROUP BY 
    product_category_name
order by 
	average_price desc;
    
/*  # KPI - 16 Highest Product Review Score.*/
  select ftb.product_id,max(ftb.review_score) as highest_review_score,ftb.product_category_name,
min(ftb.review_score) as minimum_review_score,avg  
(ftb.review_score) as avg_review_score,count(ftb.review_score) as count_score 
from(
SELECT tb1.order_id,tb2.order_item_id,tb2.product_id,tb1.review_score,product_category_name
FROM olist_order_reviews_dataset as tb1
left join olist_order_items_dataset as tb2
on tb1.order_id=tb2.order_id
left join olist_products_dataset as tb3
on tb2.product_id=tb3.product_id
where tb1.review_score <5
) as ftb 
group by 1
order by avg_review_score desc;
    
/*# Analytics KPI – 17 Delivery Performance.  */
  SELECT 
    order_id, order_estimated_delivery_date,order_delivered_customer_date,
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS delivery_performance
FROM 
    olist_orders_dataset
WHERE 
    order_delivered_customer_date IS NOT NULL
order by delivery_performance desc;

/*# Analytics KPI – 18 Relationship Between Product Categories and Payment Methods.*/
SELECT 
    product_category_name, payment_type, COUNT(*) AS count_users
FROM 
    olist_order_items_dataset oi
JOIN 
    olist_products_dataset op ON oi.product_id = op.product_id
JOIN 
    olist_order_payments_dataset opay ON oi.order_id = opay.order_id
GROUP BY 
    product_category_name, payment_type
order by count_users desc;

/*#Analytics KPI - 19 Correlation Between Review Scores And Product Prices*/
select tb1.review_score, avg(tb1.price) as avg_price
from(
select tb2.product_id,max(tb2.review_score) as review_score,max(tb2.price) as price
from(
SELECT tb3.order_id,tb4.order_item_id,tb4.product_id,tb3.review_score,tb4.price
FROM olist_order_reviews_dataset as tb3
left join olist_order_items_dataset as tb4
on tb3.order_id=tb4.order_id
left join olist_products_dataset as tb5
on tb4.product_id=tb5.product_id  
) as tb2
group by tb2.product_id
)as tb1
group by tb1.review_score;

/*# Analytics KPI – 20 Top-Selling Product Categories.*/
SELECT 
    product_category_name, round(SUM(price),2) AS total_sales
FROM 
    olist_order_items_dataset tb1
INNER JOIN 
    olist_products_dataset tb2 ON tb1.product_id = tb2.product_id
GROUP BY 
    product_category_name
ORDER BY 
    total_sales DESC;

/* # Analytics KPI – 21 The Unique Customers.*/
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers_count
FROM olist_customers_dataset;





