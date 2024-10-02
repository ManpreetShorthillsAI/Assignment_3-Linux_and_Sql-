1. Creating the employees_2023 and employees_2024 Tables
```sql
CREATE TABLE employees_2023 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);

CREATE TABLE employees_2024 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100)
);
```
2. Populating the Tables
```sql
Copy code
INSERT INTO employees_2023 (employee_id, name, department)
VALUES
(1, 'John Doe', 'Sales'),
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(4, 'Nancy White', 'HR'),
(5, 'Paul Black', 'Finance');

INSERT INTO employees_2024 (employee_id, name, department)
VALUES
(2, 'Jane Smith', 'Engineering'),
(3, 'Sam Brown', 'Marketing'),
(6, 'Peter Parker', 'IT'),
(7, 'Mary Jane', 'Sales'),
(8, 'Bruce Wayne', 'Finance');
```
3. Get Unique Employees Across Both Years
```sql
SELECT employee_id, name, department FROM employees_2023
UNION
SELECT employee_id, name, department FROM employees_2024;
```

4. Find Employees Who Worked in Both Years
```sql
SELECT employee_id, name, department FROM employees_2023
INTERSECT
SELECT employee_id, name, department FROM employees_2024;
```

5. Get Employees Who Worked Only in 2023 but Not in 2024
```sql
SELECT employee_id, name, department FROM employees_2023
EXCEPT
SELECT employee_id, name, department FROM employees_2024;
```
