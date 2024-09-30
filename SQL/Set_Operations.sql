CREATE TABLE employees_2023 (
    employee_id INT,
    name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE employees_2024 (
    employee_id INT,
    name VARCHAR(50),
    department VARCHAR(50)
);



INSERT INTO employees_2023 (employee_id, name, department) VALUES
(1, 'John Doe', 'Sales'),
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(4, 'Nancy White', 'HR'),
(5, 'Paul Black', 'Finance');




INSERT INTO employees_2024 (employee_id, name, department) VALUES
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(6, 'Peter Parker', 'IT'),
(7, 'Mary Jane', 'Sales'),
(8, 'Bruce Wayne', 'Finance');


SELECT employee_id, name, department FROM employees_2023
UNION
SELECT employee_id, name, department FROM employees_2024;


SELECT employee_id, name, department FROM employees_2023
INTERSECT
SELECT employee_id, name, department FROM employees_2024;


SELECT employee_id, name, department FROM employees_2023
EXCEPT
SELECT employee_id, name, department FROM employees_2024;

