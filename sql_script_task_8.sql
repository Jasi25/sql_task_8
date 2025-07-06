-- Drop table if exists
DROP TABLE IF EXISTS employees;

--  Create Table: Employees
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

--  Insert Sample Data
INSERT INTO employees (emp_name, department, salary) VALUES
('Alice Johnson', 'HR', 50000.00),
('Bob Smith', 'Engineering', 75000.00),
('Carol Danvers', 'HR', 52000.00),
('David Miller', 'Engineering', 80000.00),
('Eva Green', 'Sales', 47000.00);

-- Create Stored Procedure: GiveRaise
DELIMITER $$

CREATE PROCEDURE GiveRaise (
    IN p_emp_id INT,
    IN p_percent DECIMAL(5, 2)
)
BEGIN
    DECLARE old_salary DECIMAL(10,2);
    DECLARE new_salary DECIMAL(10,2);

    SELECT salary INTO old_salary
    FROM employees
    WHERE emp_id = p_emp_id;

    SET new_salary = old_salary + (old_salary * p_percent / 100);

    UPDATE employees
    SET salary = new_salary
    WHERE emp_id = p_emp_id;

    SELECT CONCAT('Employee ', p_emp_id, ' salary updated from ', old_salary, ' to ', new_salary) AS Result;
END$$

DELIMITER ;

-- Create Stored Function: GetDepartmentAverageSalary
DELIMITER $$

CREATE FUNCTION GetDepartmentAverageSalary (
    dept_name VARCHAR(50)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE avg_salary DECIMAL(10,2);

    SELECT AVG(salary)
    INTO avg_salary
    FROM employees
    WHERE department = dept_name;

    RETURN avg_salary;
END$$

DELIMITER ;
SELECT GetDepartmentAverageSalary('Engineering');
CALL GiveRaise(2, 10);


DELIMITER $$

CREATE FUNCTION CalculateAnnualSalary (
    monthly_salary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END$$

DELIMITER ;
SELECT emp_name, salary, CalculateAnnualSalary(salary) AS annual_salary
FROM employees;
