-- -- Part A

-- CREATE TABLE employees (
--     emp_id SERIAL PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     department VARCHAR(50),
--     salary INT,
--     hire_date DATE,
--     status VARCHAR(20) DEFAULT 'Active'
-- );

-- CREATE TABLE departments (
--     dept_id SERIAL PRIMARY KEY,
--     dept_name VARCHAR(50),
--     budget INT,
--     manager_id INT
-- );

-- -- Create projects table
-- CREATE TABLE projects (
--     project_id SERIAL PRIMARY KEY,
--     project_name VARCHAR(100),
--     dept_id INT,
--     start_date DATE,
--     end_date DATE,
--     budget INT
-- );


-- -- Part B

-- INSERT INTO employees(emp_id, first_name, last_name, department)
-- VALUES 
-- 	(1, 'Alice', 'Johnson', 'HR'),
--     (2, 'Bob', 'Smith', 'IT'),
--     (3, 'Charlie', 'Brown', 'Finance');

-- ALTER TABLE employees 
-- 	ALTER COLUMN salary SET DEFAULT 2000;

-- INSERT INTO employees VALUES
-- 	(4, 'Sophia', 'Anderson', 'HR', DEFAULT, '2023-05-12', DEFAULT),
--     (5, 'Liam', 'Martinez', 'IT', DEFAULT, '2024-01-20', DEFAULT);

-- INSERT INTO departments (dept_name, budget, manager_id)
-- VALUES
--     ('Human Resources', 50000, 1),
--     ('Information Technology', 120000, 2),
--     ('Finance', 80000, 3);

-- INSERT INTO employees
-- VALUES
--     ('6', 'Conor', 'Macgregor', 'MMA' ,1000000 * 1.1, CURRENT_DATE, 'Active');


-- CREATE TABLE temp_employees(
-- 	emp_id SERIAL PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     department VARCHAR(50),
--     salary INT,
--     hire_date DATE,
--     status VARCHAR(20) DEFAULT 'Active');

-- INSERT INTO temp_employees
-- 	SELECT * FROM employees
-- 		WHERE department = 'IT' OR department = 'Information Technology';


-- -- Part C

-- UPDATE employees SET salary = salary * 1.1;

-- SELECT * from employees ORDER BY salary;

-- UPDATE employees SET salary = 3500 WHERE emp_id = 1;
-- UPDATE employees SET salary = 4500 WHERE emp_id = 2;
-- UPDATE employees SET salary = 1500 WHERE emp_id = 3;


-- UPDATE employees SET status = 'Senior' WHERE salary > 3000 AND hire_date < '2026-09-01';


-- UPDATE employees
-- SET department = CASE
--     WHEN salary > 80000 THEN 'Management'
--     WHEN salary BETWEEN 3400 AND 80000 THEN 'Senior'
--     ELSE 'Junior'
-- END;


-- SELECT * from employees ORDER BY salary;

-- SELECT * from departments;


-- ALTER TABLE employees
-- ADD COLUMN dept_id INT,
-- ADD CONSTRAINT fk_employees_departments
-- FOREIGN KEY (dept_id)
-- REFERENCES departments(dept_id);

-- INSERT INTO departments (dept_name, budget, manager_id)
-- VALUES
--     ('HR', 60000, 1),
--     ('IT', 120000, 2),
--     ('Finance', 80000, 3);

-- UPDATE departments
-- SET budget = (
--     SELECT AVG(employees.salary) * 1.2
--     FROM employees
--     WHERE employees.department = departments.dept_name
-- );

-- SELECT * FROM employees;

-- UPDATE employees 
-- 	SET (salary, status) = (salary * 1.5, 'Promoted')
-- 	WHERE department = 'Senior';



-- -- Part D

-- DELETE from employees WHERE status = 'Senior';


-- SELECT * FROM employees

-- DELETE FROM employees 
-- 	WHERE salary < 2000 AND hire_date > '2023-01-01' AND department	= NULL;	


-- DELETE FROM departments
-- WHERE dept_name NOT IN (
--     SELECT DISTINCT department
--     FROM employees
--     WHERE department IS NOT NULL
-- );

-- SELECT * FROM projects;

-- INSERT INTO projects (project_name, dept_id, start_date, end_date, budget)
-- VALUES
--     ('HR Onboarding System', 1, '2023-01-15', '2023-06-30', 30000),
--     ('IT Infrastructure Upgrade', 2, '2022-09-01', '2023-03-15', 75000),
--     ('Finance Audit Automation', 3, '2023-04-01', '2023-12-31', 50000),
--     ('Recruitment Portal', 1, '2024-02-10', '2024-08-20', 40000),
--     ('Cybersecurity Enhancement', 2, '2024-05-01', '2024-11-15', 90000);


-- DELETE FROM projects 
-- 	WHERE end_date < '2024-01-01'
-- 	RETURNING *;


-- -- Part E

-- INSERT INTO employees (first_name, last_name, department, salary, hire_date, status)
-- VALUES ('Noah', 'Walker', NULL, NULL, CURRENT_DATE, 'Active');


-- SELECT * FROM employees;

-- UPDATE employees SET department	= 'Unassigned' 
-- 	WHERE department  is null;


-- -- Part F

-- INSERT INTO employees (first_name, last_name, department, salary, hire_date, status)
-- VALUES ('Ethan', 'Miller', 'Finance', 3200, CURRENT_DATE, 'Active')
-- RETURNING emp_id, first_name || ' ' || last_name as full_name;


-- UPDATE employees
-- SET salary = salary + 5000
-- WHERE department = 'IT'
-- RETURNING emp_id, salary - 5000 AS old_salary, salary AS new_salary;



-- Part G

-- INSERT INTO employees (first_name, last_name, department, salary, hire_date, status)
-- SELECT 'Alice', 'Johnson', 'HR', 2500, CURRENT_DATE, 'Active'
-- WHERE NOT EXISTS (
--     SELECT 1
--     FROM employees
--     WHERE first_name = 'Alice' AND last_name = 'Johnson'
-- );



-- CREATE TABLE employee_archive AS
-- SELECT *
-- FROM employees
-- WHERE false;   -- to create empty table with same columns


-- SELECT *
-- FROM employees
-- WHERE status = 'Inactive';


-- DELETE FROM employees
-- WHERE status = 'Inactive';

















