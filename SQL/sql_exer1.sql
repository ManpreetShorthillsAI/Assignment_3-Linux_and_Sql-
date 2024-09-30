CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2023-09-01', 350),
(2, 102, '2023-08-15', 600),
(3, 103, '2023-09-21', 150),
(4, 104, '2023-07-30', 75),
(5, 101, '2023-08-25', 480),
(6, 105, '2023-09-18', 250),
(7, 106, '2023-07-29', 500);

SELECT *
FROM orders
WHERE total_amount BETWEEN 100 AND 500
ORDER BY total_amount ASC;

SELECT *
FROM orders
WHERE total_amount BETWEEN 100 AND 500
AND order_date >= (SELECT MAX(order_date) FROM orders) - INTERVAL 30 DAY
ORDER BY total_amount ASC;