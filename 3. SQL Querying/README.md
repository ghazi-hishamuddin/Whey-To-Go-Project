# 👨‍💻 SQL Querying

## Introduction
Welcome to the SQL querying phase of the project. In this repo, I'll guide you through each step of the SQL querying process, providing considerations for the queries that will be used in the dashboard design.
Throughout this phase, we'll dive into the intricacies of SQL querying, focusing on extracting and manipulating the data needed for the dashboard. I'll be using MySQL server and workbench.

## Objectives
There are two objectives aimed in this segment. Sales and inventory data. We want to show ample information on each dashboard to reflect client's data requirements. She has provided a few things she wants to see:
+ Objective 1: Total orders, total sales, total items sold, average order value, sales per item, top selling items, orders per day, sales per day, orders by address, orders by delivery or pickup 
+ Objective 2: Inventory Overview: Total quantity by ingredient, total cost of ingredients, cost price of smoothies, percentage stock remaining by ingredient, list of ingreidents to replenish based on                                    remaining stocks
<hr>

## Creating Database and Tables

``` sql
-- Create database

CREATE DATABASE wheytogo;

USE wheytogo;

-- Create orders table

CREATE TABLE `orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(10)  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `item_id` int  NOT NULL ,
    `quantity` int  NOT NULL ,
    `cust_id` int  NOT NULL ,
    `delivery` bool  NOT NULL ,
    `add_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

-- Create customers table

CREATE TABLE `customers` (
    `cust_id` int  NOT NULL ,
    `cust_firstname` varchar(50)  NOT NULL ,
    `cust_name` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `cust_id`
    )
);

-- Create address table (address2 contains null values)

CREATE TABLE `address` (
    `add_id` int  NOT NULL ,
    `address1` varchar(200)  NOT NULL ,
    `address2` varchar(200) ,
    `city` varchar(50)  NOT NULL ,
    `postal_code` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `add_id`
    )
);


-- Create menu_item table

CREATE TABLE `menu_item` (
    `item_id` int  NOT NULL ,
    `sku` varchar(20)  NOT NULL ,
    `item_name` varchar(100)  NOT NULL ,
    `item_cat` varchar(100)  NOT NULL ,
    `item_size` varchar(10)  NOT NULL ,
    `item_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

-- Create ingredient table

CREATE TABLE `ingredient` (
    `ing_id` int  NOT NULL ,
    `ing_name` varchar(200)  NOT NULL ,
    `ing_weight` int  NOT NULL ,
    `ing_meas` varchar(20)  NOT NULL ,
    `ing_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ing_id`
    )
);

-- Create recipe table

CREATE TABLE `recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(20)  NOT NULL ,
    `ing_id` int  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

-- Create invenotry table

CREATE TABLE `inventory` (
    `inv_id` int  NOT NULL ,
    `item_id` int  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inv_id`
    )
);

-- Add Foreign Key constraints

ALTER TABLE `customers` ADD CONSTRAINT `fk_customers_cust_id` FOREIGN KEY(`cust_id`) REFERENCES `orders` (`cust_id`);

ALTER TABLE `address` ADD CONSTRAINT `fk_address_add_id` FOREIGN KEY(`add_id`) REFERENCES `orders` (`add_id`);

ALTER TABLE `menu_item` ADD CONSTRAINT `fk_menu_item_item_id` FOREIGN KEY(`item_id`) REFERENCES `orders` (`item_id`);

ALTER TABLE `ingredient` ADD CONSTRAINT `fk_ingredient_ing_id` FOREIGN KEY(`ing_id`) REFERENCES `recipe` (`ing_id`);

ALTER TABLE `recipe` ADD CONSTRAINT `fk_recipe_recipe_id` FOREIGN KEY(`recipe_id`) REFERENCES `menu_item` (`sku`);

```

## Populating Tables in MySQL
I will use the import wizard function of MySQL to populate each table in MySQL server:

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/7a3aa86e-a386-4fdf-a699-e46fd52e4f98)

``` sql
SELECT * FROM address;
SELECT * FROM customers;
SELECT * FROM ingredient;
SELECT * FROM menu_item;
SELECT * FROM orders;
SELECT * FROM inventory;
SELECT * FROM recipe;
```
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/0807e5b2-e762-4215-8f08-762e62596b82)
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/45532694-8413-4c7e-a778-0c7d7320aca3)
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/ff1a6d05-cc69-4a21-9235-b836552ee86c)
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/57a5efc9-d160-4ba5-bb4b-c6cbc864cf75)
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/64102e09-a219-4123-bf7a-9e6b809b7e43)
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/15038295-0798-4043-9408-b50675ca65bf)
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/e67e7e2c-9e8e-49bc-a701-a7c3531132f6)

Everything looks to be in order! Let's move on to our first objective.

## Objective 1:
Mentioned previously, these are the data needed to create the first dashboard:
<ol>
	<li>Total orders</li>
	<li>Total sales</li>
	<li>Total items sold</li>
	<li>Average order value</li>
	<li>Sales per item</li>
	<li>Top selling items</li>
	<li>Orders per day</li>
	<li>Sales per day</li>
	<li>Orders by address</li>
	<li>Orders by delivery or pickup</li>
</ol>

This should be straightforward, as we will just have to use a left join from the orders table to each respective table. Most of the information ca

``` sql

SELECT
    o.order_id,
    m.item_price,
    o.quantity,
    m.item_name,
    o.created_at,
    a.address1,
    a.address2,
    a.city,
    a.postal_code,
    o.delivery
   
FROM orders o
	LEFT JOIN menu_item m
		ON o.item_id = m.item_id
	LEFT JOIN address a
		ON o.add_id = a.add_id;

```
			

