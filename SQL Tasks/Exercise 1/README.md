Steps Performed
1. Creating the Database and Table
1.1 A new database named Assignment 3 was created.
1.2 A new table named orders was created
```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);
```
2. Sample data was inserted into the table.
```sql
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES 
(1, 101, '2023-09-01', 350.00),
(2, 102, '2023-08-15', 600.00),
(3, 103, '2023-09-21', 150.00),
(4, 104, '2023-07-30', 75.00),
(5, 101, '2023-08-25', 480.00),
(6, 105, '2023-09-18', 250.00),
(7, 106, '2023-07-29', 500.00);
```
3. The first task was to filter orders where the total_amount is between 100 and 500.
```sql
SELECT * 
FROM orders
WHERE total_amount BETWEEN 100 AND 500;
```
4. The results were then sorted by total_amount in ascending order.
```sql
SELECT * 
FROM orders
WHERE total_amount BETWEEN 100 AND 500
ORDER BY total_amount;
```
5. To filter orders placed in the last 30 days
```sql
SELECT * 
FROM orders
WHERE total_amount BETWEEN 100 AND 500
  AND order_date >= DATE_SUB((SELECT MAX(order_date) FROM orders), INTERVAL 30 DAY)
ORDER BY total_amount;
```
