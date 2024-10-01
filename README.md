# Assignment_3-Linux_and_Sql-

## Table of Contents
1. Linux Exercises
   - File Permissions
   - Process Management
   - Process Monitoring Script
   - File Monitoring Script
2. SQL Exercises
   - Filtering and Sorting
   - Join with Multiple Tables
   - Set Operations
3. Combining Linux and SQL
   - Database Creation Script

---

## Linux Exercises

### 1. File Permissions
**Objective**:  
- Create a file named `example.txt`.
- Change its permissions so that only the owner has read and write access, and the group and others have no permissions.

**Solution**:
```
touch example.txt             # Create the file
chmod 600 example.txt         # Change permissions
ls -l example.txt             # Verify the permissions
```

### 2. Process Management

**Objective**:  
- View running processes, identify a process by its PID, terminate it, and verify its termination.

**Solution**:
```
top                     # View running processes
pidof <process-name>    # Get the PID of the process
kill <PID>              # Terminate the process using its PID
ps aux                  # Verify the process has been terminated
```

### 3. Process Monitoring Script

**Objective**:  
- Write a shell script (`monitor_kill_processes.sh`) that continuously monitors the system for processes whose names start with "Kill_Me", terminates them, and logs the details.

**Shell Script**:
```bash
#!/bin/bash
LOG_FILE="killed_processes.log"

while true; do
    # Get processes starting with "Kill_Me"
    processes=$(ps aux | grep 'Kill_Me' | grep -v grep)
    
    if [[ ! -z "$processes" ]]; then
        # Terminate each process and log the details
        echo "$processes" | while read -r process; do
            PID=$(echo $process | awk '{print $2}')
            NAME=$(echo $process | awk '{print $11}')
            kill $PID
            echo "$(date): Killed $NAME with PID $PID" >> $LOG_FILE
        done
    fi
    
    sleep 10
done
```

1. Make the 'monitor_kill_processes.sh' script executable :
   ```
     chmod +x monitor_kill_processes.sh
   ```
3. Ensure the 'create_dummy_processes.sh' script executable :
   ```
    chmod +x create_dummy_process.sh
   ```
5. Run the 'create_dummy_processes.sh' script in a separate terminal :
   ```
    ./create_dummy_process.sh
   ```
7. Now, run the monitor_kill_processes.sh script :
   ```
    ./monitor_kill_processes.sh
**Example Log Output (saved in killed_processes.log)** :
```
Mon Sep 30 12:45:10 IST 2024 - Terminated process: PID: 12345, CMD: Kill_Me_Please_20240930_124510
Mon Sep 30 12:45:15 IST 2024 - Terminated process: PID: 12346, CMD: Kill_Me_Please_20240930_124515
```

### 4. File Monitoring Script

**Objective**:
- Write a shell script that monitors a specific directory and its subdirectories for newly created or modified files.
- Find and display the largest file by size.
- Upload the contents of new files to a local SQL database, ensuring no duplicate entries are uploaded.
- Log the name, size, and timestamp of processed files and whether duplicates were detected into a file called `file_monitor.log`.
- Set up a cron job to run the script every 10 minutes.

**Shell Script for generate.sh**:

```bash
#!/bin/bash

output_file="random_data.csv"

echo "id,name,place,job" > "$output_file"

generate_random_data() {
    local names=("Alice" "Bob" "Charlie" "David" "Eve" "Frank" "Grace" "Heidi" "Ivy" "Jack")
    local places=("New York" "London" "Paris" "Berlin" "Tokyo" "Sydney" "Cairo" "Rome" "Toronto" "Dubai")
    local jobs=("Engineer" "Doctor" "Artist" "Teacher" "Lawyer" "Nurse" "Architect" "Scientist" "Chef" "Designer")

    local id=$1
    local name=${names[$RANDOM % ${#names[@]}]}
    local place=${places[$RANDOM % ${#places[@]}]}
    local job=${jobs[$RANDOM % ${#jobs[@]}]}


    echo "$id,$name,$place,$job"
}

for i in {1..10}; do
    generate_random_data "$i" >> "$output_file"
done

echo "CSV file '$output_file' has been created with random data."

```
- Execute the generate.sh to generate the database :
  ```
  ./generate.sh
  ```
  
**Shell Script For script.sh**:

```bash
#!/bin/bash

# Directory to monitor
MONITOR_DIR="/home/shtlp_0108/Desktop/Assignment_3-Linux_and_Sql-/Linux_Rohit/Linux_5/sample_files"
# Log file location
LOG_FILE="/home/shtlp_0108/Desktop/Assignment_3-Linux_and_Sql-/Linux_Rohit/Linux_5/file_monitor.log"

# MySQL database credentials
DB_HOST="localhost"
DB_USER="root"
DB_PASSWORD="Somethingwentwrong@112"
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
1. Add all the permissions to the 'script.sh' file :
   ```
   chmod 777 scripyt.sh
   ```
2. Execute the 'script.sh' :
   ```
   ./script.sh
## SQL Exercises

### 1. Filtering and Sorting

**Objective**:
- Create a table `orders` and insert records.
- Query to select orders where the `total_amount` is between $100 and $500.
- Sort the results by `total_amount` in ascending order.
- Extend the query to filter orders placed in the last 30 days.

**SQL Queries**:

```sql
-- Select orders where the total_amount is between $100 and $500 and sort by total_amount in ascending order
SELECT * FROM orders
WHERE total_amount BETWEEN 100 AND 500
ORDER BY total_amount ASC;

-- Select orders placed in the last 30 days with total_amount between $100 and $500
SELECT * FROM orders
WHERE total_amount BETWEEN 100 AND 500
AND order_date >= CURDATE() - INTERVAL 30 DAY
ORDER BY total_amount ASC;

```
### 2. Join with Multiple Tables

**Objective**:
- Create a `customers` table and populate it with records.
- Join the `customers` and `orders` tables using `customer_id`, and display the `customer_name` and their corresponding total order amount.
- Extend the query by joining with the `products` table to show which products each customer has ordered.

**SQL Queries**:

```sql
-- Query to join customers and orders and show the total order amount per customer
SELECT customers.customer_name, SUM(orders.total_amount) AS total_order_amount
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name;

-- Query to join customers, orders, and products, showing customer names, products ordered, and total order amount
SELECT customers.customer_name, products.product_name, orders.total_amount
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN products ON products.product_id = orders.product_id;

```
### 3. Set Operations

**Objective**:
- Create two tables `employees_2023` and `employees_2024` and insert the given records.
- Use the `UNION` operator to get the list of unique employees across both years.
- Use the `INTERSECT` operator to find employees who worked in both years.
- Use the `EXCEPT` operator to get the list of employees who worked only in 2023 but not in 2024.

**SQL Queries**:

```sql
-- Unique employees across both years
SELECT employee_id, name FROM employees_2023
UNION
SELECT employee_id, name FROM employees_2024;

-- Employees who worked in both years
SELECT employee_id, name FROM employees_2023
INTERSECT
SELECT employee_id, name FROM employees_2024;

-- Employees who worked only in 2023
SELECT employee_id, name FROM employees_2023
EXCEPT
SELECT employee_id, name FROM employees_2024;

```

### Combining Linux and SQL

#### 1. Database Creation Script

**Objective**:
- Create a shell script that creates a new SQL database `company_db` with the `employees` and `departments` tables, and populates them with the given data.

**Shell Script**:

```bash
#!/bin/bash

DB_USER="root"
DB_PASS="your_password"
DB_NAME="company_db"

mysql -u $DB_USER -p$DB_PASS -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u $DB_USER -p$DB_PASS -D $DB_NAME -e "
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
INSERT INTO departments VALUES (1, 'Sales'), (2, 'Engineering'), (3, 'HR'), (4, 'Marketing'), (5, 'Finance');
INSERT INTO employees VALUES
(1, 'John Doe', 1, 50000, '2022-01-15'),
(2, 'Jane Smith', 2, 75000, '2021-05-20'),
(3, 'Sam Brown', 3, 45000, '2023-03-12'),
(4, 'Nancy White', 4, 55000, '2022-10-01'),
(5, 'Paul Black', 5, 80000, '2020-08-30');
"
```
1. In terminal, for start mysql :
   ```
    mysql -u root -p
   ```
3. To see databases :
   ```
    show databases;
   ```
5. To see tables inside databases :
   ```
    use <database-name>;
    show tables;
   ```
7. Run query to show table content :
   ```
    select * from <table-name>
   ```
