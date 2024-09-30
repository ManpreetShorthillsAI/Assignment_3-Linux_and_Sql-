USE Piyush;
CREATE TABLE `employee_2023` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`));

CREATE TABLE `employee_2024` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `department` VARCHAR(45) NULL,
  PRIMARY KEY (`employee_id`));


Insert into employee_2023 (employee_id,name,department)
values
(1,"John Doe","Sales"),
(2,"Jane Smith","Engineering"),
(3,"Sam Brown","Marketing"),
(4,"Nancy White","HR"),
(5,"Paul Black","Finance");


Insert into employee_2024 (employee_id,name,department)
values
(2,"Jane Smith","Engineering"),
(3,"Sam Brown","Marketing"),
(6,"Peter Parker","IT"),
(7,"Mary Jane","Sales"),
(8,"Bruce Wayne","Finance");

select * from employee_2024;


select distinct(name) from employee_2023
union
select distinct(name) from employee_2024;


SELECT name
FROM employee_2023
INTERSECT
SELECT name
FROM employee_2024;

SELECT name
FROM employee_2023
EXCEPT
SELECT name
FROM employee_2024




