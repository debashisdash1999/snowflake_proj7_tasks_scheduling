--  TASK 1: Creating a Simple Task (Minute-Level Scheduling)
-- Use the demo warehouse for this assignment
USE WAREHOUSE demo;

-- Create a database to store sales data for tasks
CREATE OR REPLACE DATABASE sales_db_tasks;

-- Create a table for storing sales data
CREATE OR REPLACE TABLE sales_task_table (
    order_id INTEGER,
    customer_id INTEGER,
    customer_name STRING,
    order_date DATE,
    product STRING,
    quantity INTEGER,
    price FLOAT,
    complete_address STRING
);

-- Create a task that runs every 1 minute and inserts sales data into the table
CREATE OR REPLACE TASK sales_data_task
SCHEDULE = '1 MINUTE'
WAREHOUSE = demo
AS
INSERT INTO sales_task_table (order_id, customer_id, customer_name, order_date, product, quantity, price, complete_address)
VALUES
    (1, 101, 'John Doe', CURRENT_DATE, 'Laptop', 1, 999.99, '123 Main St, City, Country'),
    (2, 102, 'Jane Smith', CURRENT_DATE, 'Headphones', 2, 199.99, '456 Oak St, City, Country');

ALTER TASK sales_data_task RESUME;

-- List all tasks in the current session
SHOW TASKS;

-- Verify if data has been inserted into the sales_task_table after the task execution
SELECT * FROM sales_task_table;

ALTER TASK sales_data_task SUSPEND;




--  TASK 2: Creating a Task Tree (Dependent Tasks)
-- Use the demo warehouse for this assignment
USE WAREHOUSE demo;

-- Create a database to store sales data for tasks
CREATE OR REPLACE DATABASE sales_db_task_tree;

-- Create a table for storing sales data
CREATE OR REPLACE TABLE sales_task_tree_table (
    order_id INTEGER,
    customer_id INTEGER,
    customer_name STRING,
    order_date DATE,
    product STRING,
    quantity INTEGER,
    price FLOAT,
    complete_address STRING
);

-- Create a root task that runs every 1 minute and inserts data into the sales_task_tree_table
CREATE OR REPLACE TASK root_task
SCHEDULE = '1 MINUTE'
WAREHOUSE = demo
AS
INSERT INTO sales_task_tree_table (order_id, customer_id, customer_name, order_date, product, quantity, price, complete_address)
VALUES
    (1, 101, 'John Doe', CURRENT_DATE, 'Laptop', 1, 999.99, '123 Main St, City, Country');

ALTER TASK root_task SUSPEND;

-- Create a child task that runs 1 minute after the root task and inserts more data into the same table
CREATE OR REPLACE TASK child_task
WAREHOUSE = demo
AFTER root_task
AS
INSERT INTO sales_task_tree_table (order_id, customer_id, customer_name, order_date, product, quantity, price, complete_address)
VALUES
    (2, 102, 'Jane Smith', CURRENT_DATE, 'Smartphone', 1, 799.99, '456 Oak St, City, Country');

-- Resume child tasks to start execution first then root
ALTER TASK child_task RESUME;

ALTER TASK root_task RESUME;

-- List all tasks to verify they are running
SHOW TASKS;

-- Verify if the data has been inserted into the sales_task_tree_table after the task executions
SELECT * FROM sales_task_tree_table;

-- Suspend the root first then child
ALTER TASK root_task SUSPEND;
ALTER TASK child_task SUSPEND;

DROP TASK IF EXISTS child_task;
DROP TASK IF EXISTS root_task;

-- Drop the table and database
DROP TABLE IF EXISTS sales_task_tree_table;
DROP DATABASE IF EXISTS sales_db_task_tree;




--  TASK 3: Creating a Task with a Daily Schedule (CRON-Based)
-- Use the demo warehouse
USE WAREHOUSE demo;

-- Create the database for the daily task
CREATE OR REPLACE DATABASE sales_db_daily_task;

-- Create the table to store sales data
CREATE OR REPLACE TABLE sales_daily_task_table (
    order_id INTEGER,
    customer_id INTEGER,
    customer_name STRING,
    order_date DATE,
    product STRING,
    quantity INTEGER,
    price FLOAT,
    complete_address STRING
);

-- Create a task that runs daily at 10 AM UTC
CREATE OR REPLACE TASK daily_sales_task
SCHEDULE = 'USING CRON 0 10 * * * UTC'
WAREHOUSE = demo
AS
INSERT INTO sales_daily_task_table (order_id, customer_id, customer_name, order_date, product, quantity, price, complete_address)
VALUES 
    (1, 101, 'John Doe', CURRENT_DATE, 'Laptop', 1, 999.99, '123 Main St, City, Country'),
    (2, 102, 'Jane Smith', CURRENT_DATE, 'Smartphone', 1, 799.99, '456 Oak St, City, Country');

-- Resume the task to enable daily execution
ALTER TASK daily_sales_task RESUME;

-- Check the task status
SHOW TASKS;

-- Verify the data inserted by the task
SELECT * FROM sales_daily_task_table;

-- Drop the task
DROP TASK IF EXISTS daily_sales_task;

-- Drop the table
DROP TABLE IF EXISTS sales_daily_task_table;

-- Drop the database
DROP DATABASE IF EXISTS sales_db_daily_task;




--  TASK 4: Analyzing Task History for a Simple Task
-- Use the demo warehouse for task execution
USE WAREHOUSE demo;

-- Create a database to store the simple task data
CREATE OR REPLACE DATABASE sales_db_simple_tasks;

-- Create a table to store sales data for the task
CREATE OR REPLACE TABLE sales_simple_task_table (
    order_id INTEGER,
    customer_id INTEGER,
    customer_name STRING,
    order_date DATE,
    product STRING,
    quantity INTEGER,
    price FLOAT,
    complete_address STRING
);

-- Create a task that runs every minute and inserts sample sales data
CREATE OR REPLACE TASK simple_data_task
SCHEDULE = '1 MINUTE'
WAREHOUSE = demo
AS
INSERT INTO sales_simple_task_table (order_id, customer_id, customer_name, order_date, product, quantity, price, complete_address)
VALUES
    (1, 101, 'John Doe', CURRENT_DATE, 'Laptop', 1, 999.99, '123 Main St, City, Country');

-- Resume the task to allow it to start executing
ALTER TASK simple_data_task RESUME;

SHOW tasks;

-- Query to check the status and next scheduled time of the task
SELECT * FROM TABLE(information_schema.task_history()) 
ORDER BY scheduled_time DESC;

select * from sales_simple_task_table;

-- Resume the task to allow it to start executing
ALTER TASK simple_data_task SUSPEND;

DROP TABLE sales_simple_task_table;

DROP DATABASE sales_db_simple_tasks;

