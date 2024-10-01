CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price INT
);
INSERT INTO products (product_id, product_name, price) VALUES
(201, 'Laptop', 1000),
(202, 'Phone', 600),
(203, 'Headphones', 100),
(204, 'Monitor', 300),
(205, 'Keyboard', 50);
SELECT c.customer_name,SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Extend the query by joining with the products table to show which products each customer has ordered

SELECT c.customer_name, p.product_name, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = o.order_id;

