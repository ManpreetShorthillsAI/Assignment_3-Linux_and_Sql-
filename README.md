# Assignment 3: Linux and SQL

## Linux Exercises

### 1. File Permissions
- **Task:** Create a file named `example.txt` and change its permissions.
- **Steps:**
  1. Create the file using the command `touch example.txt`.
  2. Set permissions so that only the owner has read and write access with `chmod 600 example.txt`.
  3. Verify permissions by running `ls -l example.txt`.

### 2. Process Management
- **Task:** Monitor and terminate a running process.
- **Steps:**
  1. View running processes using `ps aux`.
  2. Identify the process ID (PID) of an actively running process.
  3. Terminate the process using `kill <PID>`, replacing `<PID>` with the actual process ID.
  4. Verify the process has been terminated by checking the process list again.

### 3. Monitor and Terminate Processes
- **Task:** Write a script to monitor and terminate processes starting with "Kill_Me".
- **Steps:**
  1. Create a script named `monitor_kill_processes.sh` that checks for processes whose names start with "Kill_Me".
  2. Log the name, PID, and time of termination into a file named `killed_processes.log`.
  3. Use the provided script to spawn dummy processes every 30 seconds and ensure it has executable permissions with `chmod +x create_dummy_processes.sh`.

### 4. Monitor for New Files and Data Upload
- **Task:** Write a script to monitor a directory, compare file sizes, and upload unique data to SQL.
- **Steps:**
  1. Create a script named `file_monitor.sh` to monitor a specified directory and its subdirectories for new or modified files.
  2. Log the details of processed files and check for duplicates.
  3. Set up a cron job to run the script every 10 minutes by editing the crontab and adding the appropriate line.

### Deliverables
- `monitor_kill_processes.sh`: Shell script for monitoring and terminating processes.
- `killed_processes.log`: Log of terminated processes.
- `file_monitor.sh`: Shell script for monitoring files and uploading data.
- `file_monitor.log`: Log file documenting file processing.
- Evidence of the cron job setup (screenshot or log).

---

## SQL Exercises

### 1. Filtering and Sorting
- **Task:** Create an `orders` table, insert records, and query data.
- **Steps:**
  1. Create the `orders` table with appropriate columns.
  2. Insert sample records into the table.
  3. Write a query to select orders where the total amount is between $100 and $500, sorting the results by total amount in ascending order.
  4. Extend the query to filter orders placed in the last 30 days.

### 2. Join with Multiple Tables
- **Task:** Create `customers` and `products` tables and perform joins.
- **Steps:**
  1. Create the `customers` table with relevant columns and populate it with records.
  2. Create the `products` table and insert data.
  3. Write a query to join the `customers` and `orders` tables and display customer names along with their total order amounts.
  4. Extend the query to include product information.

### 3. Set Operations
- **Task:** Create employee tables and use set operations.
- **Steps:**
  1. Create `employees_2023` and `employees_2024` tables with required columns.
  2. Insert sample data into both tables.
  3. Write a query using the UNION operator to get a list of unique employees across both years.
  4. Write another query using INTERSECT to find employees who worked in both years.
  5. Use the EXCEPT operator to list employees who worked only in 2023.

### 4. Combining Linux and SQL
- **Task:** Write a script to create a new database and tables.
- **Steps:**
  1. Create a script named `create_db.sh` that connects to the MySQL server.
  2. Include commands to create a new database named `company_db` and the required tables.
  3. Populate both tables with given sample data.

### Deliverables
- SQL scripts and commands used in the exercises.
- Evidence of the SQL database created (screenshot of data).
- A log file documenting all SQL operations and outcomes.

