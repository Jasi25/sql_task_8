 Task 8 – Stored Procedures and Functions (SQL Internship task8)

 📌 Overview
This task demonstrates the use of stored procedures and stored functions in SQL using MySQL. The goal is to modularize logic for employee data operations such as salary adjustments, department-based queries, and calculating annual salary.

✅ Deliverables
🔹 Stored Procedure: `GiveRaise`
Purpose: Increase an employee's salary by a given percentage.
Parameters: 
-p_emp_id (INT) – Employee ID
-p_percent (DECIMAL) – Raise percentage
Output: Message showing updated salary

-sql
CALL GiveRaise(2, 10);
