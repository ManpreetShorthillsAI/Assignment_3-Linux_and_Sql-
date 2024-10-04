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
```

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
```

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
```

### 4. Combining Linux and SQL:
```
created script file containing below content
#!/bin/bash
 

# MySQL database credentials
DB_HOST="localhost"
DB_USER="root"
DB_PASSWORD="root"
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
"
 
echo "Database and tables created, data inserted."
 
After running sqlscript.sh file checked workbench to verify company_db database and required tables are created or not.
```


## Linux Exercise
### 1. File Permissions:
```
touch example.txt          # Create the file
chmod 600 example.txt     # Set permissions: owner (read/write), group (none), others (none)
ls -l example.txt         # Verify permissions
```

### 2. Process Management:

```
ps aux                 # View running processes
kill <PID>             # Terminate process gracefully
kill -9 <PID>          # Forcefully terminate process
ps -p <PID>            # Check if process is still running
```

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
```

### 4. Write a shell script that performs the following tasks:
```
Monitor for New Files:
The script should monitor a specific directory and its subdirectories for newly created or modified files.
File Size Comparison:
Recursively scan all directories to find and display the largest file by size.
Data Upload and Duplicate Check:
Upload the contents of new files to a local SQL database, ensuring no duplicate entries are uploaded.
Logging:
Record the name, size, and timestamp of processed files, and whether duplicates were detected, into a log file called file_monitor.log.


created script.sh to perform all the above tasks
#!/bin/bash

# Configuration
MONITOR_DIR="/home/shtlp_0070/Desktop/Assignment3/Assignment_3-Linux_and_Sql-/Linux/linux_task4/sample_files"  # Directory to monitor
DB_NAME="file_monitor_db"               # Database name
DB_USER="root"                          # Database user
DB_PASSWORD="root"                      # Database password
LOG_FILE="/home/shtlp_0070/Desktop/Assignment3/Assignment_3-Linux_and_Sql-/Linux/linux_task4/file_monitor.log"  # Log file path

# Create the log file if it doesn't exist
touch "$LOG_FILE"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to upload new files to the database
upload_file() {
    local file_path="$1"
    local file_name=$(basename "$file_path")
    local file_size=$(stat -c%s "$file_path")
    local file_timestamp=$(date -r "$file_path" '+%Y-%m-%d %H:%M:%S')

    # Check for duplicate entry
    if ! mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "SELECT * FROM files WHERE file_name='$file_name';" | grep -q "$file_name"; then
        # Insert file details into the database
        mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "INSERT INTO files (file_name, file_size, file_timestamp) VALUES ('$file_name', '$file_size', '$file_timestamp');"
        log_message "Uploaded: $file_name (Size: $file_size bytes, Timestamp: $file_timestamp)"
    else
        log_message "Duplicate detected: $file_name (Size: $file_size bytes, Timestamp: $file_timestamp)"
    fi
}

# Create the database and table if they do not exist
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "
CREATE TABLE IF NOT EXISTS files (
    id INT AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255) UNIQUE,
    file_size BIGINT,
    file_timestamp DATETIME
);"

# Monitor the directory for new files
inotifywait -m -r -e create,modify --format '%w%f' "$MONITOR_DIR" | while read NEW_FILE
do
    # Process the new or modified file
    upload_file "$NEW_FILE"
done &

# Find the largest file
while true; do
    LARGEST_FILE=$(find "$MONITOR_DIR" -type f -exec du -b {} + | sort -n | tail -1)
    if [ -n "$LARGEST_FILE" ]; then
        LARGEST_FILE_NAME=$(basename "$LARGEST_FILE")
        LARGEST_FILE_SIZE=$(echo "$LARGEST_FILE" | awk '{print $1}')
        log_message "Largest file: $LARGEST_FILE_NAME (Size: $LARGEST_FILE_SIZE bytes)"
    fi
    sleep 300  # Check every 5 minutes
done

Then Set Up the Cron Job:
Open the crontab editor:  crontab -e
Add the following line to run the script every 10 minutes: */10 * * * * /bin/bash /home/shtlp_0070/Desktop/Assignment3/Assignment_3-Linux_and_Sql-/Linux/linux_task4/script.sh
```
