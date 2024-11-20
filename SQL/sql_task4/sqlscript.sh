#!/bin/bash

# MySQL database credentials
DB_HOST="localhost"
DB_USER="root"
DB_PASSWORD="root"
DB_NAME="file_monitor_db"

# Create the database
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create tables inside the database
mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
"

# Insert data into departments table
mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "
INSERT IGNORE INTO departments (department_name) VALUES
('Sales'),
('Engineering'),
('HR'),
('Marketing'),
('Finance');
"

# Retrieve department IDs
declare -A department_ids
while IFS=$'\t' read -r id name; do
    department_ids["$name"]=$id
done < <(mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "SELECT department_id, department_name FROM departments;")

# Insert data into employees table using retrieved department IDs
mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "
INSERT INTO employees (employee_name, department_id, salary, hire_date) VALUES
('John Doe', ${department_ids[Sales]}, 50000, '2022-01-15'),
('Jane Smith', ${department_ids[Engineering]}, 75000, '2021-05-20'),
('Sam Brown', ${department_ids[HR]}, 45000, '2023-03-12'),
('Nancy White', ${department_ids[Marketing]}, 55000, '2022-10-01'),
('Paul Black', ${department_ids[Finance]}, 80000, '2020-08-30');
"

echo "Database and tables created, data inserted."

