1. Create the customers Table
```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);
```
2. Create the products Table
```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);
```
3. Insert data into the customers table:
```sql
INSERT INTO customers (customer_id, customer_name, city)
VALUES
(101, 'John Doe', 'New York'),
(102, 'Jane Smith', 'Los Angeles'),
(103, 'Sam Brown', 'Chicago'),
(104, 'Nancy White', 'Miami'),
(105, 'Paul Black', 'Boston');
```
4. Insert data into the products table:
```sql
INSERT INTO products (product_id, product_name, price)
VALUES
(201, 'Laptop', 1000.00),
(202, 'Phone', 600.00),
(203, 'Headphones', 100.00),
(204, 'Monitor', 300.00),
(205, 'Keyboard', 50.00);
```
5. Join customers and orders to Display Total Order Amount
```sql
SELECT c.customer_name, SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
```
