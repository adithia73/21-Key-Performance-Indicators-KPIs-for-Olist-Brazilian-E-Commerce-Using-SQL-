# Please adjust the default file directory to correspond with the location of your CSV file on your system. 
select version();
show variables like '%INFILE%';
set global local_infile=true;


use brazilian_e_commerce;
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET COLLATION_CONNECTION = 'utf8mb4_unicode_ci';
SET SESSION sql_mode = 'ANSI_QUOTES';
SET GLOBAL net_read_timeout = 600; -- Increase read timeout to 10 minutes
SET GLOBAL net_write_timeout = 600; -- Increase write timeout to 10 minutes
SET GLOBAL wait_timeout = 28800; -- Increase wait timeout to 8 hours
SET GLOBAL interactive_timeout = 28800; -- Increase interactive timeout to 8 hours
SET GLOBAL max_allowed_packet = 1073741824; -- Increase max allowed packet to 1 GB

DROP TABLE IF EXISTS product_category_name_translation;
CREATE TABLE IF NOT EXISTS product_category_name_translation (product_category_name	TEXT,
	product_category_name_english	TEXT
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/product_category_name_translation.csv' 
INTO TABLE product_category_name_translation 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`product_category_name`,`product_category_name_english`);
DROP TABLE IF EXISTS olist_sellers_dataset;
CREATE TABLE IF NOT EXISTS olist_sellers_dataset (
	"seller_id"	TEXT,
	"seller_zip_code_prefix"	INTEGER,
	"seller_city"	TEXT,
	"seller_state"	TEXT
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/olist_sellers_dataset.csv' 
INTO TABLE olist_sellers_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (seller_id, seller_zip_code_prefix, seller_city, seller_state);
DROP TABLE IF EXISTS olist_customers_dataset;
CREATE TABLE IF NOT EXISTS olist_customers_dataset (
	"customer_id"	TEXT,
	"customer_unique_id"	TEXT,
	"customer_zip_code_prefix"	INTEGER,
	"customer_city"	TEXT,
	"customer_state"	TEXT
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/olist_customers_dataset.csv' 
INTO TABLE olist_customers_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS  (customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state);
DROP TABLE IF EXISTS olist_geolocation_dataset;
CREATE TABLE IF NOT EXISTS olist_geolocation_dataset (
	"geolocation_zip_code_prefix"	INTEGER,
	"geolocation_lat"	REAL,
	"geolocation_lng"	REAL,
	"geolocation_city"	TEXT,
	"geolocation_state"	TEXT
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/olist_geolocation_dataset.csv' 
INTO TABLE olist_geolocation_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS  (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state);
DROP TABLE IF EXISTS olist_order_items_dataset;
CREATE TABLE IF NOT EXISTS olist_order_items_dataset (
	"order_id"	TEXT,
	"order_item_id"	INTEGER,
	"product_id"	TEXT,
	"seller_id"	TEXT,
	"shipping_limit_date"	TEXT,
	"price"	REAL,
	"freight_value"	REAL
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/olist_order_items_dataset.csv' 
INTO TABLE olist_order_items_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS  (order_id, order_item_id, product_id, seller_id, shipping_limit_date, price,freight_value);
DROP TABLE IF EXISTS olist_order_payments_dataset;
CREATE TABLE IF NOT EXISTS olist_order_payments_dataset (
	"order_id"	TEXT,
	"payment_sequential"	INTEGER,
	"payment_type"	TEXT,
	"payment_installments"	INTEGER,
	"payment_value"	REAL
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/olist_order_payments_dataset.csv' 
INTO TABLE olist_order_payments_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (order_id, payment_sequential, payment_type, payment_installments, payment_value);
DROP TABLE IF EXISTS olist_order_reviews_dataset;
CREATE TABLE IF NOT EXISTS olist_order_reviews_dataset (
	"review_id"	TEXT,
	"order_id"	TEXT,
	"review_score"	INTEGER,
	"review_comment_title"	TEXT,
	"review_comment_message"	TEXT,
	"review_creation_date"	TEXT,
	"review_answer_timestamp"	TEXT
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/olist_order_reviews_dataset.csv' 
INTO TABLE olist_order_reviews_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS  (review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp);
DROP TABLE IF EXISTS olist_orders_dataset;
CREATE TABLE IF NOT EXISTS olist_orders_dataset (
	"order_id"	TEXT,
	"customer_id"	TEXT,
	"order_status"	TEXT,
	"order_purchase_timestamp"	TEXT,
	"order_approved_at"	TEXT,
	"order_delivered_carrier_date"	TEXT,
	"order_delivered_customer_date"	TEXT,
	"order_estimated_delivery_date"	TEXT
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/olist_orders_dataset.csv' 
INTO TABLE olist_orders_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS (order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date,order_estimated_delivery_date);
DROP TABLE IF EXISTS olist_products_dataset;
CREATE TABLE IF NOT EXISTS olist_products_dataset (
	"product_id"	TEXT,
	"product_category_name"	TEXT,
	"product_name_lenght"	REAL,
	"product_description_lenght"	REAL,
	"product_photos_qty"	REAL,
	"product_weight_g"	REAL,
	"product_length_cm"	REAL,
	"product_height_cm"	REAL,
	"product_width_cm"	REAL
)DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
LOAD DATA LOCAL INFILE 'C:/Users/adith/Downloads/archive/olist_products_dataset.csv' 
INTO TABLE olist_products_dataset 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS  (product_id, product_category_name, product_name_lenght, product_description_lenght, product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm);


