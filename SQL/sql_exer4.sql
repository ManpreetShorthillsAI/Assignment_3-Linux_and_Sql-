#!/bin/bash
 
# Variables
DB_NAME="company_db"
MYSQL_USER="your_username"   # Replace with your MySQL username
MYSQL_PASS="your_password"    # Replace with your MySQL password
 
# Create the database and tables
mysql -u "$MYSQL_USER" -p"$MYSQL_PASS" -e "
DROP DATABASE IF EXISTS $DB_NAME;
CREATE DATABASE $DB_NAME;
USE $DB_NAME;
 
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
 
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'HR'),
(4, 'Marketing'),
(5, 'Finance');
 
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date