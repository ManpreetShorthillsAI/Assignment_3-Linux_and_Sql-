# Assignment_3-Linux_and_Sql-
# Linux Tasks 
## Task 1 : File Permissions 
1.Successfully created example.txt file using touch command and changed its permission to read and write to user only.
2. Cloned the repository to local machine and created a new branch 'GursehajbirSingh2' and then committed the changes to it.
![image](https://github.com/user-attachments/assets/19f8251b-f922-4e29-9a61-fa0e564d02a3)

## Task 2 : Process Management 
1. Run the 'top' command and identified a process to kill.
2. ![image](https://github.com/user-attachments/assets/c32f203f-49ca-486f-bf6d-baa72cf127e5)
3. Killed 'firefox' process with the PID : 51493
4. ![image](https://github.com/user-attachments/assets/24a27f04-100d-441d-9469-306d05441e62)

## Task 3 : Monitor and Kill Process Scripts 
1. Created a script named 'monitor_kill_processes.sh' and wrote a code to kill processess and on the other side created another file named 'dummy_script' where wrote a code to make dummy processes
2. Run both the scripts side by side then the follwing output shows:
3. ![image](https://github.com/user-attachments/assets/fcf8dec3-5d2a-4d09-a85c-d039cfa155e6)

## Task 4 : File Monitoring, Size Comparison, and Database Upload:





# SQL Tasks 
## Task 1: Filtering and Sorting 
1. Creating the Database and Table 1.1 A new database named assessment was created. 1.2 A new table named orders was created

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
![image](https://github.com/user-attachments/assets/9b8b4dfa-ef05-426e-b53c-8d327612cae0)

3. The first task was to filter orders where the total_amount is between 100 and 500.
```sql
SELECT * 
FROM orders
WHERE total_amount BETWEEN 100 AND 500;
```
![image](https://github.com/user-attachments/assets/deab2160-6c02-48d5-9e8a-c35110197db1)

4. The results were then sorted by total_amount in ascending order.
```sql
SELECT * 
FROM orders
WHERE total_amount BETWEEN 100 AND 500
ORDER BY total_amount;
```
![image](https://github.com/user-attachments/assets/ebedb5b6-9b37-416f-b008-be665d6cd295)

5. To filter orders placed in the last 30 days
```sql
SELECT * 
FROM orders
WHERE total_amount BETWEEN 100 AND 500
  AND order_date >= DATE_SUB((SELECT MAX(order_date) FROM orders), INTERVAL 30 DAY)
ORDER BY total_amount;
```
![image](https://github.com/user-attachments/assets/6b70cc1f-e2c2-4785-96f0-f80300da1a4d)

## TASK 2 : Join with Multiple Tables
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
![image](https://github.com/user-attachments/assets/698840a3-4b95-4309-88d7-57a971a32cbe)

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
![image](https://github.com/user-attachments/assets/e72b437c-bc91-4ccb-a6d1-2ceb35a5075f)


5. Join customers and orders to Display Total Order Amount
```sql
SELECT c.customer_name, SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
```
![image](https://github.com/user-attachments/assets/c7e38e33-57bf-4956-baa0-b127d475af67)




## Task 3: Set Operation
1. Created the table Employee_2023 with the necessary column names and datatypes.
```sql
CREATE TABLE employees_2023 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);
```
2. Inserted values from the employee_2023 dataset provided in the excel sheet using the commands :
```sql
INSERT INTO employees_2023 (employee_id, name, department)
VALUES
(1, 'John Doe', 'Sales'),
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(4, 'Nancy White', 'HR'),
(5, 'Paul Black', 'Finance');
```
![image](https://github.com/user-attachments/assets/12b18cbd-37e4-4600-abeb-f976f07ef800)

3. Created another table as required named as employee_2024 with the necessary columns.
```sql
CREATE TABLE employees_2024 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);
```
4. Inserted the data into the table :
```sql
INSERT INTO employees_2024 (employee_id, name, department)
VALUES
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(6, 'Peter Parker', 'IT'),
(7, 'Mary Jane', 'Sales'),
(8, 'Bruce Wayne', 'Finance');
```
![image](https://github.com/user-attachments/assets/406330b3-3bd8-4936-b39f-a9f91f443a7b)

5. Query to get the list of unique employees across both years.
```sql
SELECT employee_id, name, department
FROM employees_2023
UNION
SELECT employee_id, name, department
FROM employees_2024;
```
![image](https://github.com/user-attachments/assets/8c82327c-f18f-49ab-81c1-fbf42216574e)

6. Query to find employees who worked in both years.
```sql
SELECT employee_id, name, department
FROM employees_2023 INTERSECT SELECT employee_id, name, department FROM employees_2024;
```
![image](https://github.com/user-attachments/assets/4eddef86-1206-4d28-8793-7f7c2b0a0936)

7. Query to get the list of employees who worked only in 2023 but not in 2024.
```sql
SELECT employee_id, name, department
FROM employees_2023
EXCEPT
SELECT employee_id, name, department
FROM employees_2024;
```
![image](https://github.com/user-attachments/assets/aeb9ff96-29b9-4cb3-9f40-74943ef68244)

## Task 4 : Combining Linux and SQL
Created a shell file which:
Creates the company_db database.
Creates the departments table with department information.
Creates the employees table with employee information, linking each employee to their department using a foreign key (department_id).
Inserts data into both the departments and employees tables.
![image](https://github.com/user-attachments/assets/0d779419-e5f5-481e-9f4c-a355a2431906)


![image](https://github.com/user-attachments/assets/272169b9-9eab-46e8-8cd0-e51a4ec84723)





