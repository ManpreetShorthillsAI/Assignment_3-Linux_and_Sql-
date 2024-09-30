CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


INSERT INTO customers (customer_id, customer_name, city) VALUES
(101, 'John Doe', 'New York'),
(102, 'Jane Smith', 'Los Angeles'),
(103, 'Sam Brown', 'Chicago'),
(104, 'Nancy White', 'Miami'),
(105, 'Paul Black', 'Boston');


INSERT INTO products (product_id, product_name, price) VALUES
(201, 'Laptop', 1000),
(202, 'Phone', 600),
(203, 'Headphones', 100),
(204, 'Monitor', 300),
(205, 'Keyboard', 50);


SELECT 
    c.customer_name, 
    SUM(o.total_amount) AS total_order_amount,
    GROUP_CONCAT(p.product_name) AS products_ordered
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    products p ON o.product_id = p.product_id
GROUP BY 
    c.customer_name;
