Task 1 
CREATE TABLE orders (
    ->     order_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     order_date DATE,
    ->     total_amount DECIMAL(10, 2)
    -> );

INSERT INTO orders (order_id , customer_id, order_date , total_amount) VALUES
    -> (1,101,'2023-09-01',350),
    -> (2,102,'2023-08-15',600),
    -> (3,103,'2023-07-30',150),
    -> (4,104,'2023-08-25',75),
    -> (5, 101, '2023-08-25', 480),
    -> (6, 105, '2023-09-18', 250),
    -> (7, 106, '2023-07-29', 500);

SELECT * FROM orders
    -> WHERE total_amount BETWEEN 100 AND 500
    -> ORDER BY total_amount ASC;


SELECT * FROM orders
    -> WHERE total_amount BETWEEN 100 AND 500
    -> AND order_date >= NOW() - INTERVAL 30 DAY
    -> ORDER BY total_amount ASC;

Task 2
CREATE TABLE customers (
    ->     customer_id INT PRIMARY KEY,
    ->     customer_name VARCHAR(100),
    ->     city VARCHAR(50));


CREATE TABLE products (
    ->     product_id INT PRIMARY KEY,
    ->     product_name VARCHAR(100),
    ->     price DECIMAL(10, 2)
    -> );


INSERT INTO customers (customer_id, customer_name, city) VALUES
    -> (101, 'John Doe', 'New York'),
    -> (102, 'Jane Smith', 'Los Angeles'),
    -> (103, 'Sam Brown', 'Chicago'),
    -> (104, 'Nancy White', 'Miami'),
    -> (105, 'Paul Black', 'Boston');


INSERT INTO products (product_id, product_name, price) VALUES
    -> (201, 'Laptop', 1000),
    -> (202, 'Phone', 600),
    -> (203, 'Headphones', 100),
    -> (204, 'Monitor', 300),
    -> (205, 'Keyboard', 50);


SELECT c.customer_name, SUM(o.total_amount) AS total_order_amount
    -> FROM customers c
    -> JOIN orders o ON c.customer_id = o.customer_id
    -> GROUP BY c.customer_name;

CREATE TABLE order_items (
    ->     order_item_id INT PRIMARY KEY,
    ->     order_id INT,
    ->     product_id INT,
    ->     quantity INT,
    ->     FOREIGN KEY (order_id) REFERENCES orders(order_id),
    ->     FOREIGN KEY (product_id) REFERENCES products(product_id)
    -> );

NSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES
    -> (1, 1, 1, 2), 
    -> (2, 2, 2, 1), 
    -> (3, 4, 3, 3); 

SELECT c.customer_name, p.product_name, SUM(o.total_amount) AS total_order_amount
    -> FROM customers c
    -> JOIN orders o ON c.customer_id = o.customer_id
    -> JOIN order_items oi ON o.order_id = oi.order_id
    -> JOIN products p ON oi.product_id = p.product_id
    -> GROUP BY c.customer_name, p.product_name;


Task 3
CREATE TABLE employees_2023 (
    ->     employee_id INT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     department VARCHAR(50)
    -> );

CREATE TABLE employees_2024 (
    ->     employee_id INT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     department VARCHAR(50)
    -> );


INSERT INTO employees_2023 (employee_id, name, department) VALUES
    -> (1, 'John Doe', 'Sales'),
    -> (2, 'Jane Smith', 'Engineering'),
    -> (3, 'Sam Brown', 'Marketing'),
    -> (4, 'Nancy White', 'HR'),
    -> (5, 'Paul Black', 'Finance');

INSERT INTO employees_2024 (employee_id, name, department) VALUES
    -> (2, 'Jane Smith', 'Engineering'),
    -> (3, 'Sam Brown', 'Marketing'),
    -> (6, 'Peter Parker', 'IT'),
    -> (7, 'Mary Jane', 'Sales'),
    -> (8, 'Bruce Wayne', 'Finance');

SELECT name FROM employees_2023
    -> UNION
    -> SELECT name FROM employees_2024;

SELECT name FROM employees_2023
    -> INTERSECT
    -> SELECT name FROM employees_2024;

SELECT name FROM employees_2023
    -> EXCEPT
    -> SELECT name FROM employees_2024;


