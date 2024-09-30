USE Piyush;

CREATE TABLE `customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`));


Insert into customers (customer_id,customer_name,city)
values
(101,"John Doe","New York"),
(102,"Jane Smith","Los Angeles"),
(103,"Sam Brown","Chicago"),
(104,"Nancy White","Milami"),
(105,"Paul Black","Boston");



CREATE TABLE `products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`product_id`));


  Insert into products (product_id,product_name,price)
values
(201,"Laptop",1000),
(202,"Phone",600),
(203,"Headphones",100),
(204,"Monitor",300),
(205,"Keyboard",50);


select customer_name,total_amount from customers 
join Orders on customers.customer_id = Orders.customer_id;


SELECT 
    c.customer_name,
    SUM(p.price * o.quantity) AS total_order_amount,
    GROUP_CONCAT(p.product_name) AS ordered_products
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    products p ON o.product_id = p.product_id
GROUP BY 
    c.customer_id;





