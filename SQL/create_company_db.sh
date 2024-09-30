#!/bin/bash

# Variables
DB_NAME="company_db"
DB_USER="root"  
DB_PASS="Cherav@123"   

# Create the SQL commands
SQL_COMMANDS="
CREATE DATABASE IF NOT EXISTS $DB_NAME;
USE $DB_NAME;

CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'HR'),
(4, 'Marketing'),
(5, 'Finance');

INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date) VALUES
(1, 'John Doe', 1, 50000, '2022-01-15'),
(2, 'Jane Smith', 2, 75000, '2021-05-20'),
(3, 'Sam Brown', 3, 45000, '2023-03-12'),
(4, 'Nancy White', 4, 55000, '2022-10-01'),
(5, 'Paul Black', 5, 80000, '2020-08-30');
"

# Execute the SQL commands
mysql -u $DB_USER -p$DB_PASS -e "$SQL_COMMANDS"

# Check if the commands were executed successfully
if [ $? -eq 0 ]; then
    echo "Database and tables created successfully, and data inserted."
else
    echo "An error occurred."
fi
