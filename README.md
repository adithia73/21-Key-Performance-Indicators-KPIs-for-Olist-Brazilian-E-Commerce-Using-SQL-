

---

# 21 Key Performance Indicators (KPIs) for Olist Brazilian E-Commerce Using SQL

This repository contains SQL scripts and documentation to analyze 21 key performance indicators (KPIs) for Olist's Brazilian e-commerce operations. The dataset used for this analysis is sourced from [Kaggle's Brazilian E-commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

## Contents

1. [SQL Script to Load Data from CSV](Olist_csv_to_sql.sql)
2. [SQL Script with 21 KPI Queries](21_KPI_ Query.sql)
3. [Understanding and Measuring Key Performance Indicators for Olist's eCommerce operations](21 Analytics KPI.pdf)

## Files

### 1. Olist_csv_to_sql.sql
This SQL script contains commands to load data from CSV files into the database. It includes the creation of tables and the insertion of data from the provided CSV files. Use this script to set up your database before running the KPI queries.

```sql
-- Example of loading data
LOAD DATA LOCAL INFILE 'path/to/your/csvfile.csv'
INTO TABLE your_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

### 2. 21_KPI_ Query.sql
This SQL script includes 21 queries to calculate key performance indicators for Olist's eCommerce operations. Each query is designed to provide insights into different aspects of the business, such as sales performance, customer behavior, and operational efficiency.

```sql
-- Example KPI query
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
```

### 3. 21 Analytics KPI.pdf
This PDF provides an overview of key performance indicators (KPIs) relevant to Olist's eCommerce operations. It explains the importance of each KPI, how they are measured, and their impact on business performance. Detailed descriptions for all 21 KPIs are included.

## Usage

1. **Set up your database**: Ensure you have a MySQL database set up and ready to receive data.
2. **Load data**: Use the `Olist_csv_to_sql.sql` script to load data from the CSV files into your database.
3. **Run 21 KPI queries**: Execute the queries in `21_KPI_ Query.sql` to calculate and analyze the KPIs.

## Dataset

The dataset used in this project is the Brazilian E-commerce Public Dataset by Olist, available on [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce). It contains information on orders made at Olist stores, enabling comprehensive analysis of the e-commerce operation.

## Key Performance Indicators (KPIs)

1. **Percentage Distribution of Customers in Each State**
2. **Order Rate per Date**
3. **Cancellation Rate**
4. **Delivery Rate**
5. **Average Delivery Time**
6. **Total Order Value based on Order Date**
7. **Items Per Order**
8. **Average Product Price per Order**
9. **Highest Category Sales Value**
10. **Average Freight Value per Order**
11. **Common Payment Type**
12. **Payment Value per Order**
13. **Average Installment Payment Value**
14. **Distribution of Product Categories**
15. **Average Price of Products in Each Category**
16. **Highest Product Review Score**
17. **Delivery Performance**
18. **Relationship Between Product Categories and Payment Methods**
19. **Correlation Between Review Scores and Product Prices**
20. **Top-Selling Product Categories**
21. **Unique Customers**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

