# Assignment_3-Linux_and_Sql-

## Linux

### Linux-Task-1 - File permissions

- Created a file named `Linux-Task-1-example.txt` and changed its permissions using chmod command.
- Use touch command to create `Linux-Task-1-example.txt`.
- The 600 after chmod gives user/owen the permission to read and write and no permissions to groups and others.
- `ls -l` to see file details in long form.
```bash
touch example.txt
chmod 600 example.txt
ls -l
```
![Screenshot from 2024-09-30 17-28-18](https://github.com/user-attachments/assets/1d479c32-f5a0-417f-ab76-3a6a21b0cf23)



### Linux-Task-2 - Process Management

- Used `top` command to view running processes.
- Used `pidof` command to note the pid of the process to kill(for example: `pidof firefox` - will give the PIDs of firefox if its runnung).
- Terminated the process using its PID.
  
```bash
top
pidof firefox
kill [pid]
```
![Screenshot from 2024-09-30 17-49-45](https://github.com/user-attachments/assets/9417a3f2-e60e-48f8-984e-923f364cd9ac)
![Screenshot from 2024-09-30 18-32-05](https://github.com/user-attachments/assets/32d38de5-6b4d-49cb-a206-b0788ef68f24)




### Linux-Task-3 - Monitor and Kill processes

* `Linux_task-3-create_dummy_processes` script continuously spawns dummy processes using a while true loop and checks every 30 seconds for processes whose name starts with Kill_Me using the ps aux | grep command.
* `Linux_task-3-Monitor_kill_processes` script does the following:
* The awk command extracts the process ID (PID) and process name.
* If a process is found, its termination details (name, PID, and time) are logged in killed_processes.log,  The process is terminated using the kill -9 command.
* Each time a process is killed, the event is logged in the format: Date: Process Name with PID was terminated in `Linux_task-3-killed_processes.log`.
* The script checks for new processes every 10 seconds.
  
  ![Screenshot from 2024-09-30 18-32-05](https://github.com/user-attachments/assets/bfa22c26-b0f0-408d-94b1-b8671f9aff41)
  ![Screenshot from 2024-09-30 18-32-12](https://github.com/user-attachments/assets/f84a2c7b-847e-46c8-92bb-bf88edf30002)



### Linux-Task-4 - Shell scripts to perform tasks
- The `Linux-Task-4-generate.sh` script generates random data and outputs it in a file and stores the same data in Mysql table.
- The `Linux-Task-4-script.sh` file then monitors the directory for new created or modified files and recursively scans all directories for the largest file.
- This data about the files(name, size, and timestamp of processed files, and whether duplicates were detected) is then logged into `Linux-Task-4-file_monitor.log` file.
  
![Screenshot from 2024-09-30 20-26-25](https://github.com/user-attachments/assets/7e7c537d-0a05-41ea-85f2-ab1385b38196)
![Screenshot from 2024-09-30 20-27-17](https://github.com/user-attachments/assets/cc760ae2-9a79-49c3-adf0-f0d1e8d9cdbc)


--- 


## SQL

### SQL-Task-1 - Creating tables, filtering and sorting
- Firstly CREATE DATABASE named sql_assignment.
- Then CREATE TABLE named orders and enter the dummy data.
- Use the BETWEEN clause to filter the data of orders with total_amount >= 100 and <= 500 and 'ORDER BY' to sort the data.
- `CURDATE()`: Retrieves the current date.
  - `INTERVAL 30 DAY`: Used with `CURDATE()` to filter data from the last 30 days.
- SQL script provided in the repo.

  ![image](https://github.com/user-attachments/assets/d3bc05b8-bc77-4ead-8dde-c5d77f554b31)



### SQL-Task-2 - Join with multiple tables
- Create a table customers with columns customer_id, customer_name, and city using `CREATE TABLE` command.
- Populate it with dummy records.
- Create another table products with columns product_id, product_name, price.
- Join customers and orders tables using the `customer_id`, and display the `customer_name` and their corresponding total order amount by using the `JOIN ON` statement.
  ```SQL
    SELECT c.customer_name, o.total_amount
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id;
  ```
  ![image](https://github.com/user-attachments/assets/b54c1cfe-878b-465d-a614-1749caa91dcb)



### SQL-Task-3 - Set operations

- Create two tables, `employees_2023` and `employees_2024`, each with the columns employee_id, name, and department.
- Insert the dummy records.
- Write the queries using union, intersect and except statements:
- `UNION`: Combines the result set of two or more `SELECT` statements, returning unique records.
  - To get a list of unique employees from both the `employees_2023` and `employees_2024` tables.
    ![Screenshot from 2024-09-30 19-16-34](https://github.com/user-attachments/assets/5ac346cc-6d96-466a-a60e-c4eede717750)

- `INTERSECT`: Returns the common rows from both `SELECT` statements.
  - To find employees who worked in both 2023 and 2024.
    ![Screenshot from 2024-09-30 19-19-30](https://github.com/user-attachments/assets/132d2a03-a27f-4334-9144-22398d71df60)

- `EXCEPT`: Returns rows from the first `SELECT` statement that are not in the second `SELECT` statement.
  - To get the list of employees who worked only in 2023 but not in 2024.
    ![Screenshot from 2024-09-30 19-20-15](https://github.com/user-attachments/assets/aa332a42-0d5f-4ea2-a30f-39320f1dd46c)



### SQL-Task-4 - Combining Linux and SQL
- Initialize the MySQL variables such as db_name, db_user and db_pass in `SQL-Task-4-create_company_db.sh` script with your database credentials.
- The `SQL-Task-4-create_company_db.sh` script does the following tasks:
  - Creates a new SQL database called company_db and new tables named `employees` and `departments` and populate the tables with dummy data.
    
    ![image](https://github.com/user-attachments/assets/8e9620f3-55a8-4811-b1b7-0371a17b1c53)
    
  - This script executes all the commands in one go. These commands are to
    1. Create a database
    2. Create and polulate tables named `employees` and `departments`.
    3. Check it the data was created.

