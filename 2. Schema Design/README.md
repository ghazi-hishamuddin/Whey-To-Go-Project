# 💡 Schema Design

## Introduction
Welcome to the schema design phase of the project. In this repo, I'll provide my considerations for the database schema, efficiently capturing the client's data requirements. Afterward, we'll proceed to SQL querying to extract the necessary data for the dashboard.

## Target Areas
There are two main areas the client brief wants to concentrate on: 
+ Customer Orders
+ Inventory Control </br>

<hr>

<h2> 1. Customer Orders: </h2>

I'll need to determine the different data needed to track customer orders. To effectively track customer orders, I've organized the items data into four distinct columns: 'item_name', 'item_cat', 'item_size', and 'item_price'. Additionally, I've split the address data into four different coloumns as well. This approach enables efficient management and analysis of order details within the table. This is a sample mockup of the customer orders table:

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/41cdb297-3e65-48d5-9343-86d90984f183)

I'll be including a 'row_id' as a primary key to ensure that each row in the table has a unique identifier, as 'order_id' may be duplicated. This allows for easier management and referencing of specific orders. This how it will look like when populated:

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/f07a2f07-388d-4686-a5d6-cdb600d2ee5b)

I chose the INT data type for 'row_id' columns as they are identifiers and expected to contain integer values. I opted for the BOOL data type for delivery too, ensuring that I manipulate the data to reflect the same in the csv file. DECIMAL(5,2) would work well for 'item_price' as none of the products costs above $99. The rest of the data could be varchar(N). This is the datatypes proposed in the schema design:

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/7ab337b5-78b1-4b70-ab31-fa33b912b20d)g"  
     height="400" />

To optimize efficiency and reduce redundancy in the order table data, I propose a normalization approach by introducing identifiers for both customer names and their addresses. It aims to enhance data management and retrieval. Here's the drafted schema:

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/2c5559e1-2a62-417f-a3a8-30091d34b2db"  
     height="400" />

This serves two main purposes: It reduces the amount of data in the orders table and ensures an efficient and future-proof database, particularly if my client ever needs to change any information of an item.

<hr>


To assist in this part of the schema design, the client has provided a list of products she sells. This information can be gathered by the docx file provided in the <a href="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/tree/main/Project%20Brief">Project Brief</a> folder. We will port this information to a spreadsheet.

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/55ad1352-2f63-4c3f-99ac-bc3435c2c821"  
     height="400" />

With the addition of the menu_item table, the schema design becomes significantly more efficient compared to the initial orders table. By eliminating redundant data, this also sets a solid foundation for our upcoming inventory control objectives.

<img src="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/9389d8fc-b487-46c5-ba96-c8eb7542ae6e"  
     height="400" />

Relationships between tables:
+ The 'cust_id' in the customer table corresponds to the 'cust_id' in the orders table, establishing a link between customers and their orders.
+ The 'add_id' appears in both the address and orders tables. This connection allows for associating orders with specific delivery addresses.
+ The 'item_id' appears in both the menu_item and orders tables. This linkage facilitates tracking menu items included in each order.

<hr>
<hr>
<h2> 2. Inventory Control: </h2>
For this aspect of the schema design, the client has emphasized the need to monitor ingredient stocks to facilitate timely replenishment.

To achieve this, we must gather detailed information in the following areas:

+ <b>Ingredients Composition</b>: Identifying the ingredients required for each smoothie on the menu.
+ <b>Quantity Variation</b>: Understanding the quantity of ingredients needed based on the size of the smoothie.
+ <b>Existing Stock Levels</b>: Maintaining records of the current stock levels for each ingredient enables us to determine when to reorder supplies.

I'll assume that the lead time for delivery by suppliers is the same across all ingredients. Populating the spreadsheet, I'll be using same information from the menu items docx provided, as the client has kindly provided the products' corresponding ingredient lists. This is how the corresponding table may look like:


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

There are a few considerations I've mapped out for each table. 
<table border="1">
     <tr>
          <td>Ingredient table</td>
          <td>I started with the ingredient table first as it is the easiest to begin with. Each row represents 1 ingredient, and its price per item. For instance, a 2000 mililetres <i>(a bottle of milk)</i> of whole                   milk equates to $7.23. This data was extracted from the clients' wholesaler and updated as of February 2024.</td>
     </tr>
     <tr>
          <td>Recipe table</td>
          <td>I then populated the spreadspeed for the ingredients needed for each product. To achieve that I used the same 'SKU' digits from the menu_item table. Using the Ingredient table as a reference, I linked the                 'SKU' digits with the corresponding 'ing_id' and specified the quantity required for each ingredient <i>(measured in milliliters or grams)</i>. For example, SMT-DCB-M requires 360 mililitres of whole milk.</td>
     </tr>
     <tr>
          <td>Inventory table</td>
          <td>Lastly, I populated the spreadsheet by gathering infomation from the client. I used 'item_id' to relate the 'ing_id' from the ingredients table. For instance, the client has 25 bottls of milk.</td>
     </tr>
</table>

With that we will continue with the schema design for this three tables.

![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/59fdb3e6-008d-4620-bac2-1467fa43e3a5)


Relationships between tables:
+ The recipe_id in the recipe table corresponds to the sku in the menu_item table.
+ The ing_id appears in both the ingredient and recipe tables, indicating a relationship between them.
+ In the inventory table, the item_id can be related to the ing_id in the recipe table.

These relationships allow for linking data across different tables, enabling efficient retrieval and analysis of information related to recipes, menu items, ingredients, and inventory.

With all this data, the client can calculate exactly how much each smoothie costs to make. If supply prices go up, she just needs to update the ingredient prices in ingredient table. Additionally, she can do calculations for when to stock up on ingredients, in the inventory table. With the schema design completed, let's move on to <a href="https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/tree/main/3.%20SQL%20Querying">SQL querying</a>!

