# 📈 Dashboard Creation

## Introduction
Welcome to the Dashboard Creation phase of the project. In this repo, I'll guide you through each step of the SQL querying process, providing considerations for the queries that will be used in the dashboard design.
Throughout this phase, we'll dive into the intricacies of SQL querying, focusing on extracting and manipulating the data needed for the dashboard. I'll be using MySQL server and workbench.

## Page 1: Sales Dashboard
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/ff3a0793-646c-484c-8c66-573bccf12440)
1. <b> Key Performance Indicators</b>: This section presents several key metrics, including total sales, average order value, total items ordered, and earnings from delivery. The numerical values provide quantitative insights into business performance.
2. <b>Date Filtering</b>: This dropdown box provides the option to filter to each month.
3. <b>Total Sales</b>: The line chart displays the total sales over time, with peaks indicating periods of high sales volume. The chart shows fluctuations, suggesting varying demand patterns.
4. <b>Product Popularity</b>: The bar chart illustrates the popularity or sales volume of different products or product categories. It allows for easy comparison and identification of top-selling items.
5. <b>Delivery Analytics</b>: The pie chart represents the proportion of orders that required delivery services. The larger slice indicates a significant portion of orders involved delivery, providing insights into the demand for delivery services. This is also interactive and determine which areas are most popular for delivery.
6. <b>Geographic Information</b>: The map displays the location of the service area,  indicating customer distribution. This visual aid can help with logistics and regional analysis.

## Page 2: Inventory Dashboard
![image](https://github.com/ghazi-hishamuddin/Whey-To-Go-Project/assets/142828521/4aab4205-5c58-48db-8ff9-03c0eb25644a)
1. <b>Total ingredient cost</b>:This metric provides the ingredient costs needed for orders up to that month (March 2024)
2. <b>First table</b>: Shows the Total Projected Cost and stock levels for various ingredients/products. This table allows the client to quickly monitor their inventory levels across all ingredients/products and prioritizee replenishing the critically low stock items highlighted in red. The key columns are:
   
    + Total Quantity: Current stock level
    + Total Cost: Cost of that current stock quantity
    + Percent Remaining: Percentage of stock remaining compared to a target/maximum level Importantly, any rows with the Percent Remaining below 15% are highlighted in red. This is a visual indicator for the client to easily identify products that need to be restocked or topped up soon before running out.
  
3. <b>Second table</b>: Shows the calculation of the Cost of Standard for each of their product offerings. This provides the client with the unit economics and profitability analysis for their product lineup.

By having both tables side-by-side, the client can cross-reference their remaining ingredient stock levels from the first table against the product costs from the second table. This combined view helps them make informed decisions about production planning, inventory management, and pricing strategies to optimize costs and profitability.

<hr>
