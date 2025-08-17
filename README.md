# snowflake_proj7_tasks_scheduling
This project demonstrates task creation and scheduling in Snowflake, covering simple and dependent tasks, CRON-based schedules, and monitoring task execution. The exercises include:
Creating tasks that run automatically at regular intervals
Building task trees with dependent child tasks
Scheduling tasks using CRON expressions
Monitoring task execution and analyzing task history

The goal is to understand Snowflake’s automation capabilities for recurring data operations.

Prerequisites:
Active Snowflake account
Access to Snowflake Web UI or SnowSQL
Demo warehouse created in Project 1

Tasks Performed:-
TASK 1: Creating a Simple Task (Minute-Level Scheduling)
Created a database and table for task-based sales data
Created a task that runs every minute to insert sample sales data
Resumed the task to allow automatic execution
Used SHOW TASKS to list and monitor task status
Verified data insertion in the table
Suspended the task after verification

TASK 2: Creating a Task Tree (Dependent Tasks)
Created a database and table for task tree sales data
Created a root task running every minute to insert sample data
Created a child task that executes after the root task to insert additional data
Resumed both tasks to start execution
Verified task status and data insertion in the table
Suspended and dropped both tasks, table, and database after testing

TASK 3: Creating a Task with a Daily Schedule (CRON-Based)
Created a database and table for daily scheduled sales data
Created a task scheduled to run daily at 10 AM UTC using a CRON expression
Inserted sample sales data as part of the task execution
Resumed the task to enable daily execution
Verified scheduling and data insertion
Suspended the task and cleaned up resources

TASK 4: Analyzing Task History for a Simple Task
Created a database and table for simple task tracking
Created a simple task that runs every minute and inserts a record into the table
Resumed the task and monitored its status and next scheduled execution
Queried the table to verify inserted data
Suspended the task and cleaned up resources

Real-World Relevance:
Automated tasks enable routine operations without manual intervention
Task trees allow sequencing dependent operations for complex workflows
CRON scheduling supports daily, weekly, or custom schedules for ETL pipelines
Task monitoring and history analysis ensure reliability and traceability of recurring processes
