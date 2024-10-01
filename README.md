# Assignment_3-Linux_and_Sql-
## SQL Exercise

### TASK-1
### Filtering and Sorting:
**Create a table called orders with the following columns: order_id, customer_id, order_date, total_amount.**
```
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount INT
);

**Insert the records(Dataset for SQL Exercise 1).**
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2023-09-01', 350),
(2, 102, '2023-08-15', 600),
(3, 103, '2023-09-21', 150),
(4, 104, '2023-07-30', 75),
(5, 101, '2023-08-25', 480),
(6, 105, '2023-09-18', 250),
(7, 106, '2023-07-29', 500);

Write a query to select orders where the total_amount is between $100 and $500.
Sort the results by total_amount in ascending order.
Extend the query to filter orders placed in the last 30 days.

SELECT *
FROM orders
WHERE total_amount BETWEEN 100 AND 500
  AND order_date >= CURDATE() - INTERVAL 30 DAY
ORDER BY total_amount ASC;

### TASK-2
```
**Join with Multiple Tables:
Create a table customers with columns customer_id, customer_name, and city.
Populate it with given records (Dataset for SQL Exercise 2).**

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);
INSERT INTO customers (customer_id, customer_name, city) VALUES
(101, 'John Doe', 'New York'),
(102, 'Jane Smith', 'Los Angeles'),
(103, 'Sam Brown', 'Chicago'),
(104, 'Nancy White', 'Miami'),
(105, 'Paul Black', 'Boston');

Create another table products with columns product_id, product_name, price.
Write a query to join customers and orders using the customer_id, and display the customer_name and their corresponding total order amount.
Extend the query by joining with the products table to show which products each customer has ordered.

SELECT c.customer_name,SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

### TASK-3
```
Set Operations:
Create two tables, employees_2023 and employees_2024, each with the columns employee_id, name, and department.
Insert the given records in the table (Dataset for SQL Exercise 3).

CREATE TABLE employees_2023 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);

CREATE TABLE employees_2024 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);
INSERT INTO employees_2023 (employee_id, name, department) VALUES
(1, 'John Doe', 'Sales'),
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(4, 'Nancy White', 'HR'),
(5, 'Paul Black', 'Finance');
INSERT INTO employees_2024 (employee_id, name, department) VALUES
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(6, 'Peter Parker', 'IT'),
(7, 'Mary Jane', 'Sales'),
(8, 'Bruce Wayne', 'Finance');


Write a query using the UNION operator to get the list of unique employees across both years.

SELECT employee_id, name, department FROM employees_2023
UNION
SELECT employee_id, name, department FROM employees_2024;

Write another query using INTERSECT to find employees who worked in both years.

SELECT employee_id, name, department FROM employees_2023
INTERSECT
SELECT employee_id, name, department FROM employees_2024;

Use the EXCEPT operator to get the list of employees who worked only in 2023 but not in 2024.

SELECT employee_id, name, department FROM employees_2023
EXCEPT
SELECT employee_id, name, department FROM employees_2024;

Linux
### Task-1. File Permissions
```
Step 1: Create a file named example.txt.
Step 2: Change the permissions so that only the owner has read and write permissions, while the group and others have no permissions.
Step 3: Verify the permissions by listing the file details.
**Commands:**
_touch example.txt
chmod 600 example.txt
ls -l example.txt_
 
### Task-2. Process Management
```
Step 1: View running processes.
Step 2: Identify the PID of an actively running process.
Step 3: Terminate the process using its PID.
Step 4: Verify that the process has been terminated.
**Commands:**
_ps aux  
kill <PID>
ps -p <PID>
 
### Task-3. Monitoring Script for Terminating Processes
```
Step 1: Write a shell script named monitor_kill_processes.sh to:
Step 2: Continuously monitor for new processes.
Step 3: Terminate any process starting with "Kill_Me".
Step 4: Log the terminated process's name, PID, and time into killed_processes.log.
 
**monitor_kill_processes.sh file:**
#!/usr/bin/bash
 
# Log file for killed processes
LOG_FILE="killed_processes.log"
 
# Create or clear the log file at the start
> "$LOG_FILE"
 
echo "Monitoring for processes that start with 'Kill_Me'. Press [Ctrl+C] to stop."
 
# Infinite loop to monitor processes
while true; do
    # Find processes that start with "Kill_Me"
    for pid in $(pgrep "^Kill_Me"); do
        # Get the process name
        process_name=$(ps -p "$pid" -o comm=)
 
        # Log the details
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Killed process: $process_name (PID: $pid)" >> "$LOG_FILE"
        # Kill the process
        kill "$pid"
        echo "Killed process: $process_name (PID: $pid)"
    done
 
    # Sleep for a short duration to avoid high CPU usage
    sleep 5
done
 
Step 5: Permissions for Dummy Process Script
chmod +x dummy_process_script.sh












