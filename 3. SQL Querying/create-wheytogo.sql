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

ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_item_id` FOREIGN KEY(`item_id`) REFERENCES `recipe` (`ing_id`);

