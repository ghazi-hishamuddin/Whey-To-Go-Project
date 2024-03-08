# 👨‍💻 SQL Querying

## Introduction
Welcome to the SQL querying phase of the project. In this repo, I'll guide you through each step of the SQL querying process, providing considerations for the queries that will be used in the dashboard design.
Throughout this phase, we'll dive into the intricacies of SQL querying, focusing on extracting and manipulating the data needed for the dashboard. I'll be using MySQL server and workbench.

## Objectives
There are two objectives aimed in this segment. Sales and inventory data. We want to show ample information on each dashboard to reflect client's data requirements. She has provided a few things she wants to see:
+ Objective 1 (Sales Overview): Total orders, total sales, total items sold, average order value, sales per item, top selling items, orders per day, sales per day, orders by address, orders by delivery or pickup 
+ Objective 2 (Inventory Overview): Total quantity by ingredient, total cost of ingredients, cost price of smoothies, percentage stock remaining by ingredient, list of ingreidents to replenish based on remaining stocks
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

This should be straightforward, as we will just have to use a left join from the orders table to each respective table. Most of the information can be extracted from the orders, menu_item and address table. I will use this query for the visualization tool later on.

``` sql
USE wheytogo;

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

/* Results:

| order_id | sales  | item_name                    | order_date          | address                     | delivery_status |
|----------|--------|------------------------------|---------------------|-----------------------------|-----------------|
| 1001     | 18.70  | Vanilla Berry Burst (Large)  | 2024-01-02 08:23:00 | 123 Orchard Road            | 0               |
| 1001     | 5.75   | Mighty Muscle Munch          | 2024-01-02 08:23:00 | 123 Orchard Road            | 0               |
| 1002     | 14.70  | Pineapple Mango Tango (Reg)  | 2024-01-03 10:45:00 | 456 Marina Bay Sands #12-34 | 1               |
| 1002     | 6.00   | Protein Fuel Frenzy          | 2024-01-03 10:45:00 | 456 Marina Bay Sands #12-34 | 1               |
| 1002     | 5.00   | Power Crunch Bar             | 2024-01-03 10:45:00 | 456 Marina Bay Sands #12-34 | 1               |
| 1003     | 19.50  | Strawnana (Large)            | 2024-01-04 12:15:00 | 789 Sentosa Cove            | 1               |
| 1003     | 6.00   | Protein Packed Prodigy       | 2024-01-04 12:15:00 | 789 Sentosa Cove            | 1               |
| 1003     | 5.00   | Energy Blast Bar             | 2024-01-04 12:15:00 | 789 Sentosa Cove            | 1               |
|...       |...     |...                           |...                  |...                          |...              |
*/
```
The client mentioned that her brother, who assists with logistics, wants to implement a $7.50 fee for delivery orders. To calculate the total sales including the delivery fee, I will create a view using a CTE. This approach is necessary because each order can have multiple items, and adding the delivery fee directly to the previous query would apply the fee to each item instead of the entire order.

``` SQL
CREATE VIEW sales_with_delivery AS 
	WITH sales_data AS (
		SELECT 
			o.order_id,
			SUM(m.item_price * o.quantity) AS sales,
			o.delivery
		FROM orders o
			LEFT JOIN menu_item m ON o.item_id = m.item_id
			LEFT JOIN address a ON o.add_id = a.add_id
		GROUP BY o.order_id, o.delivery
	)
	SELECT 
		order_id,
		sales,
		delivery,
		CASE WHEN delivery = 1 THEN sales + 7.50 ELSE sales END as sales_with_delivery
	FROM sales_data;

/* "SELECT * FROM sales_with_delivery" will yield

| order_id | sales | delivery | sales_with_delivery |
|----------|-------|----------|---------------------|
| 1001     | 35.95 | 0        | 35.95               |
| 1002     | 61.40 | 1        | 68.90               |
| 1003     | 35.50 | 1        | 43.00               |
| 1004     | 51.40 | 1        | 58.90               |
| 1005     | 45.00 | 0        | 45.00               |
| 1006     | 40.90 | 1        | 48.40               |
| 1007     | 13.50 | 1        | 21.00               |
|...       |...    |...       |...                  |

*/
```

<hr>

## Objective 2:

To recap, these are the data needed to create the second dashboard: 
<ol>
	<li>Total quantity by ingredient</li>
	<li>Total cost of ingredients</li>
	<li>Cost price of smoothies</li>
	<li>Percentage stock remaining by ingredient</li>
	<li>List of ingreidents to replenish based on remaining stocks</li>
</ol>

Compared to the previous objective, this task will be more complex. To accomplish it, I need to calculate inventory usage, identify items requiring reordering, and determine the cost of producing each smoothie based on ingredient costs. This will enable effective monitoring of pricing and profitability. While creating multiple views is not ideal in a BI tool, I will create two views to achieve this objective to avoid complicating the process further in the future.

First I will have to calculate the number of orders created for each smoothie:
``` sql
USE wheytogo;

SELECT
    o.item_id,
    m.sku,
    m.item_name,
    SUM(o.quantity) as order_quantity
FROM orders o 
	LEFT JOIN menu_item m ON o.item_id = m.item_id
GROUP BY o.item_id, m.sku
ORDER BY o.item_id;


/* Results:

| item_name                        | sku       | order_quantity|
|----------------------------------|-----------|---------------|
| Dark Cocoa Crunch Blast (Reg)    | SMT-DCB-M | 7             |
| Dark Cocoa Crunch Blast (Large)  | SMT-DCB-L | 5             |
| Vanilla Berry Burst (Reg)        | SMT-VBB-M | 20            |
| Vanilla Berry Burst (Large)      | SMT-VBB-L | 6             |
| Tropical Hulk Fuel (Reg)         | SMT-THF-M | 8             |
| Choco Almond Coco Craze (Reg)    | SMT-CAC-M | 3             |
| Choco Almond Coco Craze (Large)  | SMT-CAC-L | 6             |
| Peachy Creamsicle Delight (Reg)  | SMT-PCD-M | 10            |
| Pineapple Mango Tango (Reg)      | SMT-PMT-M | 12            |
| Pineapple Mango Tango (Large)    | SMT-PMT-L | 8             |
| Kiwi Kickstart Booster (Reg)     | SMT-KKB-M | 5             |
| Kiwi Kickstart Booster (Large)   | SMT-KKB-L | 5             |
| Strawnana (Reg)                  | SMT-SNN-M | 16            |
| Strawnana (Large)                | SMT-SNN-L | 6             |
| Power Crunch Bar                 | PTB-PCB   | 26            |
| Mighty Muscle Munch              | PTB-MMM   | 40            |
| Protein Packed Prodigy           | PTB-PPP   | 36            |
| Energy Blast Bar                 | PTB-EBB   | 27            |
| Protein Fuel Frenzy              | PTB-PFF   | 52            |

*/
```
Moving on, I will need to break down the smoothies by ingredient. That can be done by left joining to the recipe table. This query will provide the breakdown of each smoothie with their ing_id. 
``` sql
SELECT
    o.item_id,
    m.sku,
    m.item_name,
    r.ing_id,
    r.quantity AS recipe_quantity,
    SUM(o.quantity) AS order_quantity
FROM orders o 
	LEFT JOIN menu_item m ON o.item_id = m.item_id
    LEFT JOIN recipe r ON m.sku = r.recipe_id
GROUP BY o.item_id, m.sku, r.ing_id, r.quantity
ORDER BY o.item_id;


/* Results:

| item_id | sku       | item_name                        | ing_id        | recipe_quantity | order_quantity |
|---------|-----------|----------------------------------|---------------|-----------------|----------------|
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 1             | 360             | 7              |
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 3             | 30              | 7              |
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 5             | 60              | 7              |
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 9             | 8               | 7              |
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 11            | 240             | 7              |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 1             | 600             | 5              |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 3             | 45              | 5              |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 5             | 80              | 5              |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 9             | 12              | 5              |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 11            | 360             | 5              |
| ...     | ...       |...                               |...            |...              |...             |

*/
```

To obtain the ingredient names and calculate the cost and ingredient cost, I need to left join the ingredient table. The ingredient table contains the necessary information, such as ingredient names, weights, and prices, required for unit cost and ingredient cost calculations.

``` SQL

SELECT
    o.item_id,
    m.sku,
    m.item_name,
    r.ing_id,
    i.ing_name,
    r.quantity AS recipe_quantity,
    SUM(o.quantity) AS order_quantity,
    i.ing_weight,
    i.ing_price
FROM orders o 
	LEFT JOIN menu_item m ON o.item_id = m.item_id
    LEFT JOIN recipe r ON m.sku = r.recipe_id
	LEFT JOIN ingredient i ON r.ing_id = i.ing_id
GROUP BY o.item_id, m.sku, r.ing_id, i.ing_name, r.quantity, i.ing_weight, i.ing_price
ORDER BY o.item_id;

/* Results:

| item_id | sku       | item_name                        | ing_id        | ing_name                   | recipe_quantity | order_quantity | ing_weight        | ing_price        |
|---------|-----------|----------------------------------|---------------|--------------------------- |-----------------|----------------|-------------------|------------------|
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 1             | Whole milk                 | 360             | 7              | 2000              | 7.23             |
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 3             | Chocolate protein powder   | 30              | 7              | 2000              | 70.21            |
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 5             | Peanut butter              | 60              | 7              | 500               | 8.21             |
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 9             | Dark chocolate cocoa powder| 8               | 7              | 250               | 6.61             |
| 1       | SMT-DCB-M | Dark Cocoa Crunch Blast (Reg)    | 11            | Bananas                    | 240             | 7              | 3000              | 10.84            |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 1             | Whole milk                 | 600             | 5              | 2000              | 7.23             |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 3             | Chocolate protein powder   | 45              | 5              | 2000              | 70.21            |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 5             | Peanut butter              | 80              | 5              | 500               | 8.21             |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 9             | Dark chocolate cocoa powder| 12              | 5              | 250               | 6.61             |
| 2       | SMT-DCB-L | Dark Cocoa Crunch Blast (Large)  | 11            | Bananas                    | 360             | 5              | 3000              | 10.84            |
|...      | ...       | ...                              |...            |...                         |...              |...             |...                |...               |
```

At this point, I will have to do calculations to find the unit cost and ingredient cost for each ingredient of each smoothie. To do that, I will create a subquery named sales1, as "SUM(o.quantity) as order_quantity" is already in the SELECT field. Using a subquery will also make the tables tidier. At this point we have completed the following: Total quantity by ingredient, Total cost of ingredients and Cost price of smoothies. I will create a new view for this SQL query for our next points of objective 2.

``` SQL
CREATE VIEW stock_1 AS
SELECT
    sales1.item_name,
    sales1.ing_id,
    sales1.ing_name,
    sales1.ing_weight,
    sales1.ing_price,
    sales1.order_quantity,
    sales1.recipe_quantity,
    sales1.order_quantity * sales1.recipe_quantity AS ordered_weight,
    sales1.ing_price/sales1.ing_weight AS unit_cost,
    (sales1.order_quantity * sales1.recipe_quantity) * (sales1.ing_price/sales1.ing_weight) AS ingredient_cost

FROM (SELECT
    o.item_id,
    m.sku,
    m.item_name,
    r.ing_id,
    i.ing_name,
    r.quantity AS recipe_quantity,
    SUM(o.quantity) AS order_quantity,
    i.ing_weight,
    i.ing_price
FROM orders o 
    LEFT JOIN menu_item m ON o.item_id = m.item_id
    LEFT JOIN recipe r ON m.sku = r.recipe_id
    LEFT JOIN ingredient i ON r.ing_id = i.ing_id
GROUP BY o.item_id, m.sku, r.ing_id, i.ing_name, r.quantity, i.ing_weight, i.ing_price
ORDER BY o.item_id) sales1

/* "SELECT * FROM stock_1" would yield:

| item_name                      | ing_id        | ing_name                    | ing_weight        | ing_price        | order_quantity | recipe_quantity | ordered_weight          | unit_cost     | ingredient_cost |
|--------------------------------|---------------|-----------------------------|-------------------|------------------|----------------|-----------------|-------------------------|---------------|-----------------|
| Dark Cocoa Crunch Blast (Reg)  | 1             | Whole milk                  | 2000              | 7.23             | 7              | 360             | 2520                    | 0.003615      | 9.109800        |
| Dark Cocoa Crunch Blast (Reg)  | 3             | Chocolate protein powder    | 2000              | 70.21            | 7              | 30              | 210                     | 0.035105      | 7.372050        |
| Dark Cocoa Crunch Blast (Reg)  | 5             | Peanut butter               | 500               | 8.21             | 7              | 60              | 420                     | 0.016420      | 6.896400        |
| Dark Cocoa Crunch Blast (Reg)  | 9             | Dark chocolate cocoa powder | 250               | 6.61             | 7              | 8               | 56                      | 0.026440      | 1.480640        |
| Dark Cocoa Crunch Blast (Reg)  | 11            | Bananas                     | 3000              | 10.84            | 7              | 240             | 1680                    | 0.003613      | 6.070399        |
| Dark Cocoa Crunch Blast (Large)| 1             | Whole milk                  | 2000              | 7.23             | 5              | 600             | 3000                    | 0.003615      | 10.845000       |
| Dark Cocoa Crunch Blast (Large)| 3             | Chocolate protein powder    | 2000              | 70.21            | 5              | 45              | 225                     | 0.035105      | 7.898625        |
| Dark Cocoa Crunch Blast (Large)| 5             | Peanut butter               | 500               | 8.21             | 5              | 80              | 400                     | 0.016420      | 6.568000        |
| Dark Cocoa Crunch Blast (Large)| 9             | Dark chocolate cocoa powder | 250               | 6.61             | 5              | 12              | 60                      | 0.026440      | 1.586400        |
| Dark Cocoa Crunch Blast (Large)| 11            | Bananas                     | 3000              | 10.84            | 5              | 360             | 1800                    | 0.003613      | 6.503999        |
|...                             | ...           | ...                         |...                |...               |...             |...              |...                      |...             |
```

I will now move to the final part of the SQL querying which is to determine the ercentage stock remaining by ingredient and creating a list of ingreidents to replenish based on remaining stocks. To do that we will first calculate the ordered_weight from the "stock_1" view we created above.

``` SQL
SELECT
    ing_id,
    ing_name,
    SUM(ordered_weight) AS ordered_weight
FROM stock_1
GROUP BY ing_id, ing_name

/* Results:

| ing_id        | ing_name                    | ordered_weight|
|---------------|-----------------------------|---------------|
| 1             | Whole milk                  | 46200         |
| 3             | Chocolate protein powder    | 885           |
| 5             | Peanut butter               | 820           |
| 9             | Dark chocolate cocoa powder | 116           |
| 11            | Bananas                     | 8640          |
| 4             | Vanilla protein powder      | 1500          |
| 12            | Strawberry                  | 6600          |
| 13            | Blueberry                   | 1600          |
| 14            | Raspberry                   | 960           |
| 15            | Blackberry                  | 1210          |
| 2             | Coconut milk                | 8280          |
| 10            | Spinach                     | 400           |
| 16            | Mango                       | 3316          |
| 17            | Pineapple                   | 3956          |
| 6             | Almond butter               | 900           |
| 8             | Ice                         | 2100          |
| 18            | Peaches                     | 3400          |
| 19            | Orange                      | 4976          |
| 7             | Plain Greek yogurt          | 20235         |
| 20            | Kiwis                       | 3150          |
| 21            | Power Crunch Bar            | 26            |
| 22            | Mighty Muscle Munch         | 40            |
| 23            | Protein Packed Prodigy      | 36            |
| 24            | Energy Blast Bar            | 27            |
| 25            | Protein Fuel Frenzy         | 52            |
```
Based on the previous table, I can perform the necessary calculations to determine the inventory stock levels. To achieve this, I will join the inventory and ingredient tables. Since the calculation for the ordered weight of each ingredient has been done, the only thing left to do is to calculate the ingredient weight multiplied by the inventory quantity to obtain the available stock the client has. Here's how I did it:

``` SQL

USE wheytogo;

SELECT
    stock1.ing_name,
    stock1.ordered_weight,
    inv.quantity * ing.ing_weight AS total_inv_weight,
    (inv.quantity * ing.ing_weight) - stock1.ordered_weight AS remaining_weight


FROM (SELECT
	ing_id,
	ing_name,
    SUM(ordered_weight) as ordered_weight
FROM stock_1
GROUP BY ing_id, ing_name) stock1

LEFT JOIN inventory inv ON stock1.ing_id = inv.item_id
LEFT JOIN ingredient ing ON stock1.ing_id = ing.ing_id

/* Results:

| ing_name                    | ordered_weight | total_inv_weight | remaining_weight |
|-----------------------------|----------------|------------------|------------------|
| Whole milk                  | 46200          | 50000            | 3800             |
| Plain Greek yogurt          | 20235          | 21000            | 765              |
| Strawberry                  | 6600           | 12000            | 5400             |
| Bananas                     | 8640           | 9000             | 360              |
| Coconut milk                | 8280           | 9000             | 720              |
| Ice                         | 2100           | 7500             | 5400             |
| Raspberry                   | 960            | 6000             | 5040             |
| Mango                       | 3316           | 6000             | 2684             |
| Pineapple                   | 3956           | 6000             | 2044             |
| Peaches                     | 3400           | 6000             | 2600             |
| Orange                      | 4976           | 6000             | 1024             |
| Kiwis                       | 3150           | 6000             | 2850             |
| Chocolate protein powder    | 885            | 4000             | 3115             |
| Blueberry                   | 1600           | 3000             | 1400             |
| Blackberry                  | 1210           | 3000             | 1790             |
| Vanilla protein powder      | 1500           | 2000             | 500              |
| Peanut butter               | 820            | 1000             | 180              |
| Spinach                     | 400            | 1000             | 600              |
| Almond butter               | 900            | 1000             | 100              |
| Dark chocolate cocoa powder | 116            | 500              | 384              |
| Protein Fuel Frenzy         | 52             | 60               | 8                |
| Mighty Muscle Munch         | 40             | 50               | 10               |
| Protein Packed Prodigy      | 36             | 50               | 14               |
| Energy Blast Bar            | 27             | 50               | 23               |
| Power Crunch Bar            | 26             | 40               | 14               |


*/
```
I've also calculated the remaining_weight by subtracting the ordered_weight. This will enable the client to track when to replenish each ingredient.

<hr>

That concludes the custom SQL querying section of the project. Next up, I will create the <a href="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/tree/main/4.%20Dashboard%20Creation">BI dashboard</a> using Google Looker!
