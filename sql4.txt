----- Created table ----->
CREATE TABLE `company_db`.`departments` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`));

-----5 data is inserted ------>
use company_db;
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'Engineering'),
(3, 'HR'),
(4, 'Marketing'),
(5, 'Finance');

<---------another table creation with foreign key ------>
CREATE TABLE `company_db`.`employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `employee_name` VARCHAR(45) NOT NULL,
  `department_id` INT NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `hire_date` DATE NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `department_id`
    FOREIGN KEY (`department_id`)
    REFERENCES `company_db`.`departments` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


    ------ Insert value in the tale 2 ----->

    INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date) VALUES
(1, 'John Doe', 1, 50000, '2022-01-15'),
(2, 'Jane Smith', 2, 75000, '2021-05-20'),
(3, 'Sam Brown', 3, 45000, '2023-03-12'),
(4, 'Nancy White', 4, 55000, '2022-10-01'),
(5, 'Paul Black', 5, 80000, '2020-08-30');

--- show the table ----->
SELECT * FROM departments;

SELECT * FROM employees;


