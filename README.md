# Assignment_3-Linux_and_Sql
## Linux Tasks 
### Linux-1. File Permissions
Step 1: Create a file named example.txt.
```
_touch example.txt
```
Step 2: Change the permissions so that only the owner has read and write permissions, while the group and others have no permissions.
```
chmod 600 example.txt
```
Step 3: Verify the permissions by listing the file details.
```
ls -l example.txt_
```
### Linux-2. Process Management
Step 1: View running processes.
```
_ps aux
```
Step 2: Identify the PID of an actively running process.<br>
Step 3: Terminate the process using its PID.
```
kill <PID>
```
Step 4: Verify that the process has been terminated.
``` 
ps -p <PID>
```

### Linux-3. Monitoring Script for Terminating Processes
Step 1: Write a shell script named monitor_kill_processes.sh to:<br>
Step 2: Continuously monitor for new processes.<br>
Step 3: Terminate any process starting with "Kill_Me".<br>
Step 4: Log the terminated process's name, PID, and time into killed_processes.log.<br>

### monitor_kill_processes.sh file:
```
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
```
Step 5: Permissions for Dummy Process Script
```
chmod +x dummy_process_script.sh
```

### Linux-4. File Monitoring and Database Upload Script
Step 1: Write a shell script that:<br>
Step 2: Monitors a specific directory for newly created or modified files.<br>
Step 3: Finds and displays the largest file by size.<br>
Step 4: Uploads contents of new files to a local SQL database without duplicates.<br>
Step 5: Logs processed files into file_monitor.log.<br>

### script.sh
```
#!/bin/bash

# Directory to monitor
MONITOR_DIR="/home/shtlp_0010/Desktop/Assignment_3-Linux_and_Sql-/Assignment_3-Linux_and_Sql-/Linux_Diksha/Linux_4/sample_files"
# Log file location
LOG_FILE="/home/shtlp_0010/Desktop/Assignment_3-Linux_and_Sql-/Assignment_3-Linux_and_Sql-/Linux_Diksha/Linux_4/file_monitor.log"

# MySQL database credentials
DB_HOST="localhost"
DB_USER="root"
DB_PASSWORD="#jaya@123D"
DB_NAME="file_monitor_db"

# Ensure the log file exists
touch "$LOG_FILE"

# Function to upload data to MySQL database from CSV
upload_csv_to_db() {
  local csv_file="$1"

  # Read the CSV file line by line
  while IFS=',' read -r id name place job; do
    # Skip the header line
    if [[ "$id" == "id" ]]; then
      continue
    fi

    # Log the file processing
    echo "$(date): Processing record ID '$id', Name: $name, Place: $place, Job: $job" >> "$LOG_FILE"

    # Check for duplicates by ID
    duplicate_check=$(mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -sse "SELECT COUNT(*) FROM files WHERE id='$id';")

    if [ "$duplicate_check" -eq 0 ]; then
      # Insert new record into the MySQL database
      mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -e "INSERT INTO files (id, name, place, job) VALUES ('$id', '$name', '$place', '$job');"
      echo "$(date): Uploaded record with ID '$id' to database." >> "$LOG_FILE"
    else
      echo "$(date): Duplicate ID '$id' detected, not uploaded." >> "$LOG_FILE"
    fi
  done < <(tail -n +2 "$csv_file")  # Skip the header line
}

# Function to upload new files to MySQL database
upload_to_db() {
  local file_path="$1"
  local file_size="$2"
  local file_timestamp="$3"

  # Check for duplicates
  duplicate_check=$(mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -sse "SELECT COUNT(*) FROM files WHERE file_name='$file_path';")

  if [ "$duplicate_check" -eq 0 ]; then
    # Insert new file details into the MySQL database
    mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -e "INSERT INTO files (file_name, file_size, timestamp) VALUES ('$file_path', $file_size, '$file_timestamp');"
    echo "$(date): Uploaded '$file_path' to database." >> "$LOG_FILE"
  else
    echo "$(date): Duplicate file '$file_path' detected, not uploaded." >> "$LOG_FILE"
  fi
}

# Create the MySQL database and table if they don't exist
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -e "CREATE TABLE IF NOT EXISTS files (id INT AUTO_INCREMENT PRIMARY KEY, file_name VARCHAR(255) UNIQUE, file_size BIGINT, timestamp DATETIME);"

# Monitor for new or modified files in the last 10 minutes
find "$MONITOR_DIR" -type f -newermt '-10 minutes' | while read -r file; do
  # Get file details
  file_size=$(stat -c%s "$file")
  file_timestamp=$(stat -c%y "$file")

  # Log the file processing
  echo "$(date): Processing file '$file', Size: $file_size bytes, Timestamp: $file_timestamp" >> "$LOG_FILE"

  # Upload to MySQL database
  upload_to_db "$file" "$file_size" "$file_timestamp"
done

# Process the CSV file
csv_file="$MONITOR_DIR/random_data.csv"
if [[ -f "$csv_file" ]]; then
  upload_csv_to_db "$csv_file"
fi

# Find and display the largest file
largest_file=$(find "$MONITOR_DIR" -type f -exec du -b {} + | sort -n | tail -1)
if [ -n "$largest_file" ]; then
  echo "$(date): Largest file: $largest_file" >> "$LOG_FILE"
fi
```

### Linux-5. Cron Job Setup
Set up a cron job to run the file monitoring script every 10 minutes.
```
crontab -e
```
### Add the following line
```
*/10 * * * * /path/to/your_script.sh
```
### Deliverables
1. monitor_kill_processes.sh: Script for monitoring and terminating processes.
2. killed_processes.log: Log of terminated processes.
3. File monitoring script with duplicate check.
4. file_monitor.log: Log of processed files.
5. Evidence of the cron job setup (screenshot or log).
6. Local SQL database with uploaded data.


## SQL Tasks

### 1. Filtering and Sorting:
1. Database Setup
Before starting, ensure you have access to a SQL database where we can execute the following commands.<br>

2. Table Creation
Create a table called orders with the following columns:
```
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount INT
);
```
3. Inserting Records
Insert sample records into the orders table. Below is an example dataset.
```
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2023-09-01', 350),
(2, 102, '2023-08-15', 600),
(3, 103, '2023-09-21', 150),
(4, 104, '2023-07-30', 75),
(5, 101, '2023-08-25', 480),
(4, 105, '2023-09-18', 250),
(5, 106, '2023-07-29', 500);
```
4. Query Execution
Write a query to select orders where the total_amount is between $100 and $500, and sort the results by total_amount in ascending order. Extend the query to filter orders placed in the last 30 days.
```
SELECT * FROM orders
WHERE total_amount BETWEEN 100 AND 500
AND order_date >= (SELECT MAX(order_date) FROM orders) - INTERVAL 30 DAY
ORDER BY total_amount ASC;
```

### 2. Join with Multiple Tables:
1. Database Setup
Ensure you have access to a SQL database (e.g., MySQL, PostgreSQL) where you can execute the following commands.<br>
2. Table Creation
Create Customers Table:
```
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
```
Create Products Table:
```
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price INT
);
```
Inserting Records:
```
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
```

4. Query Execution
Join customers and orders to display customer names and total order amounts:
```
SELECT c.customer_name, SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
```

Extend the query by joining with the products table:
```
SELECT 
    c.customer_name, 
    p.product_name, 
    SUM(o.total_amount) AS total_order_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON p.product_id = o.order_id 
GROUP BY c.customer_name, p.product_name;
```
### 3. Set Operations:

1. Database Setup
2. Table Creation:
Create Employees 2023 Table:
```
CREATE TABLE employees_2023 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);
```
Create Employees 2024 Table:
```
CREATE TABLE employees_2024 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);
```

3. Inserting Records
Populate Employees 2023 Table:
```
INSERT INTO employees_2023 (employee_id, name, department) VALUES
(1, 'John Doe', 'Sales'),
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(4, 'Nancy White', 'HR'),
(5, 'Paul Black', 'Finance');
```
Populate Employees 2024 Table:
```
INSERT INTO employees_2024 (employee_id, name, department) VALUES
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(6, 'Peter Parker', 'IT'),
(7, 'Mary Jane', 'Sales'),
(8, 'Bruce Wayne', 'Finance');
```
4. Query Execution
 UNION Query:
 ```
SELECT employee_id, name, department FROM employees_2023
UNION
SELECT employee_id, name, department FROM employees_2024;
```

INTERSECT Query:
```
SELECT employee_id, name, department FROM employees_2023
INTERSECT
SELECT employee_id, name, department FROM employees_2024;
```

EXCEPT Query:
```
SELECT employee_id, name, department FROM employees_2023
EXCEPT
SELECT employee_id, name, department FROM employees_2024;
```

### 4. Combining Linux and SQL:
1. Database Setup<br>
2. Script Creation<br>
Create a script file named create_company_db.sql that contains all necessary commands to create the database and tables, as well as populate them with data.
```
#!/bin/bash
 
# Database credentials

DB_USER="root"

DB_PASS="#jaya@123D"

DB_NAME="company_db"
 
# Create the company_db database

mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
 
# Create tables inside company_db

mysql -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "

CREATE TABLE IF NOT EXISTS departments (

    department_id INT PRIMARY KEY,

    department_name VARCHAR(100)

);
 
CREATE TABLE IF NOT EXISTS employees (

    employee_id INT PRIMARY KEY,

    employee_name VARCHAR(100),

    department_id INT,

    salary DECIMAL(10, 2),

    hire_date DATE,

    FOREIGN KEY (department_id) REFERENCES departments(department_id)

);

"
 
# Insert data into departments table

mysql -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "

INSERT INTO departments (department_id, department_name) VALUES

(1, 'Sales'),

(2, 'Engineering'),

(3, 'HR'),

(4, 'Marketing'),

(5, 'Finance');

"
 
# Insert data into employees table

mysql -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "

INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date) VALUES

(1, 'John Doe', 1, 50000, '2022-01-15'),

(2, 'Jane Smith', 2, 75000, '2021-05-20'),

(3, 'Sam Brown', 3, 45000, '2023-03-12'),

(4, 'Nancy White', 4, 55000, '2022-10-01'),

(5, 'Paul Black', 5, 80000, '2020-08-30');
```
3.Executing the Script
1. Save the above SQL commands in a file named create_company_db.sql.

2. Use your SQL command line tool or database management interface to execute the script. 
```
mysql -u root -p < create_company_db.sql
```
3. Check the results in the database by querying the tables:
```
USE company_db;
SELECT * FROM departments;
SELECT * FROM employees;
```
