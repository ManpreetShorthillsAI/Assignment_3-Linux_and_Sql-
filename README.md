# Assignment 3: Linux and SQL

## SQL Exercises

### 1. Filtering and Sorting

**Create the `orders` table:**

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);


To insert records following query can be executed:
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2023-09-01', 350),
(2, 102, '2023-08-15', 600),
(3, 103, '2023-09-21', 150),
(4, 104, '2023-07-30', 75),
(5, 101, '2023-08-25', 480),
(6, 105, '2023-09-18', 250),
(7, 106, '2023-07-29', 500);

Query to select orders where the total_amount is between $100 and $500 and then Sort the results by total_amount in ascending order.
After that extend the query to filter orders placed in the last 30 days
where clause is used for filtering and order by clause for sorting
SELECT *
FROM orders
WHERE total_amount BETWEEN 100 AND 500
AND order_date >= (SELECT MAX(order_date) FROM orders) - INTERVAL 30 DAY
ORDER BY total_amount ASC;

### 2. Join with Multiple Tables:
```
Created customers and products and then inserted data given in excel file of assignment

To join customers and orders the customer_id column is used, and then to display the customer_name and their corresponding total order amount group by clause is used with aggregate funciton sum
SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

To extend the query by joining with the products table to show which products each customer has ordered we require foreign key to establish the relationship but there is no such foreign key given to join product table

### 3. Set Operations:
```
Created the required tables and inserted given data
Used the UNION operator to get the list of unique employees across both years.
SELECT 
    employee_id, 
    name, 
    department 
FROM employees_2023
UNION
SELECT 
    employee_id, 
    name, 
    department 
FROM employees_2024;

Used INTERSECT to find employees who worked in both years.
SELECT employee_id, name, department FROM employees_2023
INTERSECT
SELECT employee_id, name, department FROM employees_2024;


Used the EXCEPT operator to get the list of employees who worked only in 2023 but not in 2024.
SELECT 
    employee_id, 
    name, 
    department 
FROM employees_2023

EXCEPT

SELECT 
    employee_id, 
    name, 
    department 
FROM employees_2024;



## Linux Exercise
### 1. File Permissions:
```
touch example.txt          # Create the file
chmod 600 example.txt     # Set permissions: owner (read/write), group (none), others (none)
ls -l example.txt         # Verify permissions

### 2. Process Management:
```
ps aux                 # View running processes
kill <PID>             # Terminate process gracefully
kill -9 <PID>          # Forcefully terminate process
ps -p <PID>            # Check if process is still running

### 3. Write a shell script that continuously monitors the system for new processes.
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
