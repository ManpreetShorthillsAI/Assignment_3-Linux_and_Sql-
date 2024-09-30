#!/bin/bash

# Create a new SQL database
mysql -u root -p -e "CREATE DATABASE company_db;"

# Use the database and create tables
mysql -u root -p company_db <<EOF
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
EOF

# Populate departments table
mysql -u root -p company_db <<EOF
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'HR'),
(4, 'Marketing'),
(5, 'Finance');
EOF

# Populate employees table
mysql -u root -p company_db <<EOF
INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date) VALUES
(1, 'John Doe', 1, 50000, '2022-01-15'),
(2, 'Jane Smith', 2, 75000, '2021-05-20'),
(3, 'Sam Brown', 3, 45000, '2023-03-12'),
(4, 'Nancy White', 4, 55000, '2022-10-01'),
(5, 'Paul Black', 5, 80000, '2020-08-30');
EOF

