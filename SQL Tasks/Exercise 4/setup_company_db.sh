#!/bin/bash

# 1. Connect to MySQL and create a new database called company_db
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

# 2. Create the departments table first
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

# 3. Create the employees table after departments table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

# 4. Insert data into the departments table
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'HR'),
(4, 'Marketing'),
(5, 'Finance');

# 5. Insert data into the employees table
INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date) VALUES
(1, 'John Doe', 1, 50000.00, '2022-01-15'),
(2, 'Jane Smith', 2, 75000.00, '2021-05-20'),
(3, 'Sam Brown', 3, 45000.00, '2023-03-12'),
(4, 'Nancy White', 4, 55000.00, '2022-10-01'),
(5, 'Paul Black', 5, 80000.00, '2020-08-30');
"

echo "Database and tables have been successfully created and populated."

