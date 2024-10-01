CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
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

INSERT INTO customers (customer_id, customer_name, city)
VALUES
(101, 'John Doe', 'New York'),
(102, 'Jane Smith', 'Los Angeles'),
(103, 'Sam Brown', 'Chicago'),
(104, 'Nancy White', 'Miami'),
(105, 'Paul Black', 'Boston');

INSERT INTO products (product_id, product_name, price)
VALUES
(201, 'Laptop', 1000),
(202, 'Phone', 600),
(203, 'Headphones', 100),
(204, 'Monitor', 300),
(205, 'Keyboard', 50);

INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES
(1, 101, '2023-09-01', 350),
(2, 102, '2023-08-15', 600),
(3, 103, '2023-09-21', 150),
(4, 104, '2023-07-30', 75),
(5, 101, '2023-08-25', 480);

SELECT c.customer_name, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;


-- Cannot join the products table with the above result as there is no common column(s) to faciliate a join.