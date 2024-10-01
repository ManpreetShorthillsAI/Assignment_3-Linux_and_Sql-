# Assignment_3-Linux_and_Sql-

Linux Exercise:



 ## Task 1: File Creation and Permission Modification
- Created a file named example.txt:
- Command used: touch example.txt

- Changed the permissions of example.txt so that only the owner has r -  read and write permissions:

 - Command used : chmod 600 example.txt

 - attached the sceenshot named example.txt.png

![example.txt](Linux/example.txt.png)

 
# task 2  
     
     
- Checked the running processes on the system using the process status ps -ux

- Killed a specific process by using the kill command.

- Verified if the process was successfully terminated by checking its process ID    ps -p   pid

- Attached a screenshot named killed_processes.png showing the terminated processes.

![processkill](Linux/killed_processe.png)


# task 3

- created a bash script in file named   create_dummy_process.sh that will create new dummy processes in every 30 seconds and 
  given the exutable permition using chmod 
- created another bash script in the file monitor_kill_process.sh that will will search the processes with name starting with Kill 
  and given the exutable permition for that
- and also it will generate log file named "kill_processes.log"  that will store all the log history of this processes


- dummy process created 

![dummyprocesses](Linux/dummyprocess_created.png)

- log file storing loghistory ![logfileimage](image-1.png)



- ## Task 4  
   - Shell script that monitor for new files, do file size comparison, log the details.

    - Run the shell script `script.sh` that will monitor the directory `sample_files` and log the details in `file_monitor.log`.

    - Largest file size will be scaned and shown in the output in the log file `file_monitor.log`.

    - Set up a cron job to run the script every 10 minutes

        ![alt text](Linux/Task-4/image.png)

- cheak for the codes and files structure in Task-4 folder inside the directory Linux





#   SQL Exercise :


## task 1   Filtering and Sorting


- created the a database named sql_assignment  using the command  create database sql_assignment

     ![alt text](sql/creadted_db_inseted_data.png)

- Created a table called orders with the following columns: order_id, customer_id, order_date, total_amount.
- inserted the data into tables 
- Written  a query to select orders where the total_amount is between $100 and $500

    ![ammount between $100 and $500 ](sql/ammount_in_between.png)
      
-  Sort the results by total_amount in ascending order.
 ![alt text](sql/sorted_in_asc.png)

 - Extended  the query to filter orders placed in the last 30 days.

     
      ![order_last30days](sql/last_30_days.png)
     

- cheak for the sorting.sql for the code


## Task 2 Join with Multiple Tables:

 - Created a table customers with columns customer_id, customer_name, and city.
     

  - Inserted data in it 


  ![alt text](sql/costmertable.png)

   - Create another table products with columns product_id, product_name, price.

     ![alt text](sql/product.png)
 - Written a query to join customers and orders using the customer_id, and display the customer_name and their corresponding total order ,amount.



     ![alt text](sql/join_query_multiple_table.png)


 - Cheak for the code in  join_multipletables.sql


 

## Task 3  Set Operations:


- Created two tables, employees_2023 and employees_2024, each with the    columns employee_id, name, and department.


 - Inserted  the given records in the table (Dataset for SQL Exercise 3).

    ![alt text](sql/employees_table.png)


 -   Written  a query using the UNION operator to get the list of unique employees across both years.

       ![alt text](sql/uniou_operator.png)

  - Written another query using INTERSECT to find employees who worked in both years.

       ![alt text](sql/intersect.png)


   -   Use the EXCEPT operator to get the list of employees who worked only in 2023 but not in 2024
      
          ![alt text](sql/Except_operator.png)





   ## Task 4  combining linux and sql


     
  -  Written a script that creates a new SQL databases  called company_db.

   -   Inside the script, includeded  commands to create the employees    and     departments tables as described in the  exercises.



  -  inserted the  both tables with given data (Dataset for SQL Exercise 4).

-    executed all commands in one go, and ensured  and  checked  the results in the database afterward.

   ![alt text](sql/Sql_linux_combined.png)


   - cheake for the script and code in  create_company_db.sh





       

   




        

    
















