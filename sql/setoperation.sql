CREATE TABLE employees_2023 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);

INSERT INTO employees_2023 (employee_id, name, department) VALUES
(1, 'John Doe', 'Sales'),
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(4, 'Nancy White', 'HR'),
(5, 'Paul Black', 'Finance');

CREATE TABLE employees_2024 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);

INSERT INTO employees_2024 (employee_id, name, department) VALUES
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(6, 'Peter Parker', 'IT'),
(7, 'Mary Jane', 'Sales'),
(8, 'Bruce Wayne', 'Finance');

-- Write a query using the UNION operator to get the list of unique employees across both years.
SELECT employee_id, name, department 
FROM employees_2023

UNION

SELECT employee_id, name, department 
FROM employees_2024;

-- Write another query using INTERSECT to find employees who worked in both years.
SELECT employee_id, name, department 
FROM employees_2023

INTERSECT

SELECT employee_id, name, department 
FROM employees_2024;

--  Use the EXCEPT operator to get the list of employees who worked only in 2023 but not in 2024.
SELECT employee_id, name, department 
FROM employees_2023

EXCEPT

SELECT employee_id, name, department 
FROM employees_2024;
