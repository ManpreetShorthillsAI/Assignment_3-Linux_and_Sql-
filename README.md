# Assignment_3-Linux_and_Sql-

**SQL:-
Database Creation:**
We created a new database called company_db to store our data.

**Table Creation:**
**We created two tables:**
departments: This table holds information about different departments, including:
department_id (unique identifier)
department_name (name of the department)

employees: This table contains details about employees, including:
employee_id (unique identifier)
employee_name (name of the employee)
department_id (links the employee to a department)
salary (employee's salary)
hire_date (date when the employee was hired)

**Data Insertion:**
We added sample data to both tables:
departments: We filled it with five departments like Sales, Engineering, and Finance.
employees: We added five employees with their names, salaries, and hire dates.

**Checking the Data:**
We learned how to connect to the MySQL database from the terminal.
We executed SQL commands to view the data in both the departments and employees tables.

**Running SQL from a File:**
We created an SQL file to store our commands, making it easy to run multiple commands at once.
We executed this file to see the data, and we also learned how to save the output to another file for later review.



**LINUX:-
File Permissions:**
touch command to create the example.txt file
chmod 600 example.txt modified its permissions so that only I, as the owner, can read and write to it, while the group and others have no access. Verified the permission changes by listing the file details using the ls -l command

**Process Management:**
Used a command to view all running processes.
Found the process ID (PID) of an actively running process (like my terminal).
Terminated that process using its PID.
Checked to ensure that the process was successfully stopped.

**Monitoring and Terminating Processes:**
Shell script that continuously monitors the system for new processes.
First create the process by running the script, create_dummy_processes.sh. It will give us the processes with 'Kill_Me' names in it.
Create the scirpt monitor_kill_processes.sh which will kill the processes with 'Kill_Me' name init.
A log file killed_processes.log will get created, which will show us the killed processes details.
touch spawn_dummy_processes.sh to create the file.
Nano spawn_dummy_processes.sh to change the contents of the file using nano editor.
cat spawn_dummy_processes.sh to see the contents of the file.
chmod +x create_dummy_processes.sh to change the file permissions to execute
./create_dummy_processes.sh to see the killed processes

**File Monitoring and Database Upload:**
Logged the name, size, timestamp of processed files, and any duplicates detected into a log file named file_monitor.log.
The Linux-Task-4-generate.sh script generates random data and outputs it in a file and stores the same data in Mysql table.
The Linux-Task-4-script.sh file then monitors the directory for new created or modified files and recursively scans all directories for the largest file.
This data about the files(name, size, and timestamp of processed files, and whether duplicates were detected) is then logged into Linux-Task-4-file_monitor.log file.
Set up a cron job to run this script every 10 minutes.
