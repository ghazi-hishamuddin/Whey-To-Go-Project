## Target Areas
There are two main areas the client brief requires us to concentrate on: 
+ Customer Orders
+ Inventory Control </br>

<hr>
<h2> 1. Customer Orders: </h2>

We need to determine the different data needed to track customer orders. This is a sample mockup of the customer orders table:

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/41cdb297-3e65-48d5-9343-86d90984f183)

I will including a row_id as a primary key to ensure that each row in the table has a unique identifier, as order_id may be duplicated. This allows for easier management and referencing of specific orders.
This how it will look like when populated:

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/f07a2f07-388d-4686-a5d6-cdb600d2ee5b)

This is datatypes proposed in the schema design:

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/7ab337b5-78b1-4b70-ab31-fa33b912b20d)g"  
     height="400" />


To optimize efficiency and reduce redundancy in the order data, I propose a normalization approach by introducing identifiers for both customer names and their addresses. This streamlined schema design aims to enhance data management and retrieval. Here's the drafted schema:

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/2c5559e1-2a62-417f-a3a8-30091d34b2db"  
     height="400" />

This will serve two main purposes: Reduce the amount of data in the orders table and provides an efficient and futureproof database if my client needs to ever make changes to the name of an item.