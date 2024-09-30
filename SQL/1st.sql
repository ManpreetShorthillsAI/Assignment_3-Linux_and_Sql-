Use Piyush;

CREATE TABLE `Orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` VARCHAR(45) NOT NULL,
  `total_amount` INT NOT NULL,
  PRIMARY KEY (`order_id`));

Insert into Orders (order_id,customer_id,order_date,total_amount)
values
(1,101,"9/1/2023",350),
(2,102,"8/15/2023",600),
(3,103,"9/21/2023",150),
(4,104,"7/30/2023",75),
(5,101,"8/25/2023",480),
(6,105,"9/18/2013",250),
(7,106,"7/29/2023",500);


select order_id, total_amount from Orders where total_amount
 between 100 and 500;

select order_id, total_amount from Orders order by total_amount;

SELECT *
FROM Orders
WHERE total_amount BETWEEN 100 AND 500
AND order_date >= (SELECT MAX(order_date) FROM Orders) - INTERVAL 30 DAY
ORDER BY total_amount ASC;


