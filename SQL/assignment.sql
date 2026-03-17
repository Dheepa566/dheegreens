create database company_db;
USE company_db;
GO
CREATE TABLE skills (
    skill_id INT IDENTITY(1,1) PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    category VARCHAR(100)
);
SELECT name FROM sys.databases;
SELECT name FROM sys.tables;
/*EXEC sp_rename 'employee', 'staff';*/

CREATE TABLE department (
    dept_id INT IDENTITY(1,1) PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE employee (
    emp_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    hire_date DATE,
    salary DECIMAL(10,2),
    dept_id INT,
    gender VARCHAR(20),
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE project (
    project_id INT IDENTITY(1,1) PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(12,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO employee (first_name, last_name, email, hire_date, salary, dept_id, gender)
VALUES ('Alice', 'Green', 'alice.green@company.com', '2024-01-10', 62000.00, 1, 'Female');

INSERT INTO employee (first_name, last_name, email, hire_date, salary, dept_id, gender)
VALUES ('John', 'Doe', 'john.doe@company.com', '2023-06-15', 50000.00, 1, 'Male');
INSERT INTO employee (first_name, last_name, email, hire_date, salary, dept_id, gender)
VALUES ('Emma', 'Wilson', 'emma.wilson@company.com', '2023-08-12', 70000.00, 2, 'Female');
INSERT INTO employee (first_name, last_name, email, hire_date, salary, dept_id, gender)
VALUES ('David', 'Miller', 'david.miller@company.com', '2023-05-20', 68000.00, 2, 'Male');
INSERT INTO project (project_name, budget, dept_id)
VALUES
('Mobile App', 60000.00, 2),
('Training Program', 25000.00, 1);

INSERT INTO department (dept_name, location)
VALUES ('Sales', 'Boston');

INSERT INTO department (dept_name, location)
VALUES ('IT', 'San Francisco');

SELECT * 
FROM department;

INSERT INTO employee (first_name, email)
VALUES ('Tom', 'tom@company.com');

SELECT * FROM employee;

SELECT * FROM department;

SELECT 
    emp_id AS 'Employee ID',
    first_name AS 'Name',
    salary AS 'Salary'
FROM employee;

SELECT *
FROM employee
WHERE hire_date > '2023-01-01';

SELECT *
FROM project
WHERE budget > 40000.00
ORDER BY budget DESC;

SELECT DISTINCT location
FROM department;

ALTER TABLE employee
ADD phone_number VARCHAR(15);

UPDATE employee
SET salary = 65000.00
WHERE first_name = 'John' AND last_name = 'Doe';

UPDATE employee
SET gender = 'Other'
WHERE dept_id = 2;

ALTER TABLE employee
DROP COLUMN phone_number;

SELECT *
FROM employee
WHERE salary BETWEEN 60000 AND 80000;

SELECT *
FROM employee
WHERE first_name LIKE 'J%';

SELECT *
FROM project
WHERE dept_id IN (1, 2);

SELECT *
FROM project
WHERE dept_id = 1 OR dept_id = 2;

SELECT *
FROM employee
WHERE email IS NOT NULL;

SELECT *
FROM department
WHERE location NOT IN ('New York', 'Chicago');

SELECT *
FROM employee
WHERE YEAR(hire_date) = 2023;

SELECT SUM(salary) AS total_salary
FROM employee;

SELECT AVG(budget) AS avg_budget
FROM project;

SELECT MAX(salary) AS highest_salary
FROM employee;

SELECT COUNT(*) AS employee_count
FROM employee
WHERE dept_id = 2;

SELECT MIN(budget) AS min_budget
FROM project;

SELECT MIN(budget) AS min_budget
FROM project;

SELECT e.*, d.dept_name
FROM employee e
INNER JOIN department d
ON e.dept_id = d.dept_id;

SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM department d
LEFT JOIN employee e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT p.project_name, p.budget, d.dept_name
FROM project p
INNER JOIN department d
ON p.dept_id = d.dept_id;

SELECT e.*
FROM employee e
INNER JOIN department d
ON e.dept_id = d.dept_id
WHERE d.location = 'San Francisco';

SELECT d.*
FROM department d
LEFT JOIN project p
ON d.dept_id = p.dept_id
WHERE p.project_id IS NULL;

SELECT first_name + ' ' + last_name AS 'Full Name'
FROM employee;

SELECT UPPER(dept_name) AS dept_name
FROM department;

SELECT LEFT(email, 3) AS first_3_chars
FROM employee;

SELECT ABS(-50000) AS absolute_value;

SELECT ROUND(AVG(salary), 2) AS rounded_avg_salary
FROM employee;

SELECT TOP 3 *
FROM employee
ORDER BY hire_date DESC;

SELECT *
FROM employee
ORDER BY emp_id
OFFSET 0 ROWS
FETCH NEXT 3 ROWS ONLY;

SELECT *
FROM employee
ORDER BY emp_id
OFFSET 3 ROWS
FETCH NEXT 3 ROWS ONLY;

SELECT first_name, salary,
       CASE 
           WHEN salary >= 70000 THEN 'High'
           ELSE 'Low'
       END AS salary_level
FROM employee;

SELECT project_name, budget,
       CASE
           WHEN budget >= 60000 THEN 'Large'
           WHEN budget >= 40000 THEN 'Medium'
           ELSE 'Small'
       END AS budget_category
FROM project;

SELECT dept_id, SUM(budget) AS total_budget
FROM project
GROUP BY dept_id;

SELECT TOP 1 *
FROM employee
ORDER BY LEN(first_name) DESC;

SELECT *
FROM employee
WHERE hire_date >= DATEADD(DAY, -90, '2025-03-22')
  AND hire_date <= '2025-03-22';

DELETE FROM employee
WHERE salary < 60000;

DROP TABLE project;

USE AdventureWorksLT2025;
GO

EXEC sp_helpfile;

USE master;
GO

ALTER DATABASE AdventureWorksLT2025
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO