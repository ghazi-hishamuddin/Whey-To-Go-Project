## Target Areas
There are two main areas the client brief wants to concentrate on: 
+ Customer Orders
+ Inventory Control </br>

<hr>

<h2> 1. Customer Orders: </h2>

We need to determine the different data needed to track customer orders. This is a sample mockup of the customer orders table:

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/41cdb297-3e65-48d5-9343-86d90984f183)

I will including a row_id as a primary key to ensure that each row in the table has a unique identifier, as order_id may be duplicated. This allows for easier management and referencing of specific orders.
This how it will look like when populated:

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/f07a2f07-388d-4686-a5d6-cdb600d2ee5b)

This is the datatypes proposed in the schema design:

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/7ab337b5-78b1-4b70-ab31-fa33b912b20d)g"  
     height="400" />

To optimize efficiency and reduce redundancy in the order data, I propose a normalization approach by introducing identifiers for both customer names and their addresses. This streamlined schema design aims to enhance data management and retrieval. Here's the drafted schema:

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/2c5559e1-2a62-417f-a3a8-30091d34b2db"  
     height="400" />

This will serve two main purposes: Reduce the amount of data in the orders table and provides an efficient and futureproof database if my client needs to ever make changes to the name of an item.

<hr>


To assist in this part of the schema design, the client has provided a list of menu items she sells. This information can be gathered by the docx file provided in the <a href="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/tree/main/Project%20Brief">Project Brief</a> folder. We will port this information to a spreadsheet.

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/55ad1352-2f63-4c3f-99ac-bc3435c2c821"  
     height="400" />

This is how the schema design will look like with menu item added. Comparing to the first orders table, it is much more effective without the redundant data. This table will greatly help for our next objective of inventory control.

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/9389d8fc-b487-46c5-ba96-c8eb7542ae6e"  
     height="400" />

Relationships between tables:
+ The cust_id in the customer table corresponds to the cust_id in the orders table, establishing a link between customers and their orders.
+ The add_id appears in both the address and orders tables, indicating a relationship between them. This connection allows for associating orders with specific delivery addresses.
+ The item_id appears in both the menu_item and orders tables, suggesting a relationship between them. This linkage facilitates tracking menu items included in each order.

<hr>
<hr>
<h2> 2. Inventory Control: </h2>
For this part of the schema design, the client has instructed that she wants to be able to know when it’s time to order new stocks. 

To achieve this, we are going to need more information about:

+ What ingredients go into each smoothie
+ Their quantity based on the size of the smoothie
+ The existing stocks available

I will assume that the lead time for delivery by suppliers is the same of ALL ingredients. Populating the spreadsheet, I will be using same list of this menu items provided, as she has kindly provided each ingredient that is needed for each smoothie item.


<table border="1">
  <tr>
    <td>Ingredient table</td>
    <td>Recipe table</td>
    <td>Inventory table</td>
  </tr>
  <tr>
    <td><img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/89784ff8-3f5f-4ee0-ac91-963f0dbf3744"  
     height="400" /></td>
    <td><img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/d33d3e4d-75e6-4631-a91c-d2bad5f88afe"  
     height="400" /></td>
    <td><img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/d302a48a-824c-49c9-8d1d-c89b83d44a75"  
     height="400" /></td>
  </tr>
</table>

With that we will continue with the schema design for this three tables.

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/59fdb3e6-008d-4620-bac2-1467fa43e3a5)


Relationships between tables:
+ The recipe_id in the recipe table corresponds to the sku in the menu_item table.
+ The ing_id appears in both the ingredient and recipe tables, indicating a relationship between them.
+ In the inventory table, the item_id can be related to the ing_id in the recipe table.

These relationships allow for linking data across different tables, enabling efficient retrieval and analysis of information related to recipes, menu items, ingredients, and inventory.

With all this data, the client can calculate exactly how much each smoothie costs to make. If supply prices go up, she just needs to update the ingredient prices in ingredient table. Additionally, she can do calculations for when to stock up on ingredients, in the inventory table. With the schema design completed, let's move on to SQL querying!

