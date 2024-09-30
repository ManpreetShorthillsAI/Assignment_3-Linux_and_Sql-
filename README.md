# Assignment_3-Linux_and_Sql-

SQL:-
Database Creation:
We created a new database called company_db to store our data.

Table Creation:
We created two tables:
departments: This table holds information about different departments, including:
department_id (unique identifier)
department_name (name of the department)

employees: This table contains details about employees, including:
employee_id (unique identifier)
employee_name (name of the employee)
department_id (links the employee to a department)
salary (employee's salary)
hire_date (date when the employee was hired)

Data Insertion:
We added sample data to both tables:
departments: We filled it with five departments like Sales, Engineering, and Finance.
employees: We added five employees with their names, salaries, and hire dates.

Checking the Data:
We learned how to connect to the MySQL database from the terminal.
We executed SQL commands to view the data in both the departments and employees tables.

Running SQL from a File:
We created an SQL file to store our commands, making it easy to run multiple commands at once.
We executed this file to see the data, and we also learned how to save the output to another file for later review.



LINUX:-
File Permissions:
Created a file named example.txt.
Changed the file permissions so that only I (the owner) can read and write it, while others and the group have no access.
Verified the permissions by listing the file details.

Process Management:
Used a command to view all running processes.
Found the process ID (PID) of an actively running process (like my terminal).
Terminated that process using its PID.
Checked to ensure that the process was successfully stopped.

Monitoring and Terminating Processes:
Created a shell script named monitor_kill_processes.sh that continuously checks for new processes.
The script identifies and kills any process that starts with "Kill_Me".
It logs the name, PID, and time of any terminated processes into a file called killed_processes.log.
Used another script to spawn dummy processes every 30 seconds and ensured that my script worked properly.

File Monitoring and Database Upload:
Wrote a shell script to monitor a specific directory for newly created or modified files.
The script checks the size of files and identifies the largest one.
It uploads new files to a local SQL database while preventing duplicates.
Logged the name, size, timestamp of processed files, and any duplicates detected into a log file named file_monitor.log.
Set up a cron job to run this script every 10 minutes.
