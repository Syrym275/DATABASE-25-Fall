-- -- Create tables
--  CREATE TABLE employees (
--     employee_id SERIAL PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     department VARCHAR(50),
--     salary NUMERIC(10,2),
--     hire_date DATE,
--     manager_id INTEGER,
--     email VARCHAR(100)
--  );
--  CREATE TABLE projects (
--     project_id SERIAL PRIMARY KEY,
--     project_name VARCHAR(100),
--     budget NUMERIC(12,2),
--     start_date DATE,
--     end_date DATE,
--     status VARCHAR(20)
--  );
--  CREATE TABLE assignments (
--     assignment_id SERIAL PRIMARY KEY,
--     employee_id INTEGER REFERENCES employees(employee_id),
--     project_id INTEGER REFERENCES projects(project_id),
--     hours_worked NUMERIC(5,1),
--     assignment_date DATE
--  );


-- -- Insert sample data
--  INSERT INTO employees (first_name, last_name, department, 
-- salary, hire_date, manager_id, email) VALUES
--  ('John', 'Smith', 'IT', 75000, '2020-01-15', NULL, 
-- 'john.smith@company.com'),
--  ('Sarah', 'Johnson', 'IT', 65000, '2020-03-20', 1, 
-- 'sarah.j@company.com'),
--  ('Michael', 'Brown', 'Sales', 55000, '2019-06-10', NULL, 
-- 'mbrown@company.com'),
--  ('Emily', 'Davis', 'HR', 60000, '2021-02-01', NULL, 
-- 'emily.davis@company.com'),
--  ('Robert', 'Wilson', 'IT', 70000, '2020-08-15', 1, NULL),
--  ('Lisa', 'Anderson', 'Sales', 58000, '2021-05-20', 3, 
-- 'lisa.a@company.com');
--  INSERT INTO projects (project_name, budget, start_date, 
-- end_date, status) VALUES
--  ('Website Redesign', 150000, '2024-01-01', '2024-06-30', 
-- 'Active'),
--  ('CRM Implementation', 200000, '2024-02-15', '2024-12-31', 
-- 'Active'),
--  ('Marketing Campaign', 80000, '2024-03-01', '2024-05-31', 
-- 'Completed'),
--  ('Database Migration', 120000, '2024-01-10', NULL, 'Active');
--  INSERT INTO assignments (employee_id, project_id, 
-- hours_worked, assignment_date) VALUES
--  (1, 1, 120.5, '2024-01-15'),
--  (2, 1, 95.0, '2024-01-20'),
--  (1, 4, 80.0, '2024-02-01'),
--  (3, 3, 60.0, '2024-03-05'),
--  (5, 2, 110.0, '2024-02-20'),
--  (6, 3, 75.5, '2024-03-10');



-- -- Part 1
-- SELECT first_name || ' ' || last_name as full_name, department, salary
-- FROM employees

-- SELECT DISTINCT department FROM employees;

-- SELECT project_name, budget, 
-- CASE 
-- WHEN budget > 150000 THEN 'Large'
-- WHEN budget BETWEEN 100000 AND 150000 THEN 'Medium'
-- ELSE 'Small'
-- END 
-- as budget_category
-- FROM projects;

-- SELECT first_name, COALESCE(email, 'No email provided') 
-- FROM employees;


-- -- Part 2

-- SELECT * FROM employees WHERE hire_date > '01.01.2020';
-- SELECT * FROM employees WHERE salary BETWEEN 60000 AND 70000;
-- SELECT * FROM employees WHERE last_name LIKE 'S%' OR last_name LIKE'J%';
-- SELECT * FROM employees WHERE department = 'IT' AND manager_id IS NOT NULL;



-- -- Part 3

-- SELECT UPPER(first_name) FROM employees;
-- SELECT LENGTH(last_name) FROM employees;
-- SELECT SUBSTRING(email, 0, 4) FROM employees;

-- SELECT 
-- salary*12 as annual_salary,
-- ROUND(salary, 2) as monthly_salary,
-- salary*1.1 as raised_salary
-- FROM employees;


-- SELECT 
--     FORMAT(
--         'Project: %s - Budget: $%s - Status: %s', 
--         project_name, 
--         budget, 
--         status
--     ) AS project_info
-- FROM projects;

-- SELECT 
--     last_name,
--     DATE_PART('year', AGE(CURRENT_DATE, hire_date)) AS years_with_company
-- FROM employees;


-- -- Part 4

-- SELECT department, AVG(salary) as average_salary
-- 	FROM employees
-- 	GROUP BY department;

-- SELECT project_name, DATEDIFF(HOUR, start_date, end_date AS hours_spent
-- FROM projects
-- GROUP BY project_name;

-- SELECT 
--     department,
--     COUNT(*) AS employee_count
-- FROM employees
-- GROUP BY department
-- HAVING COUNT(*) > 1;

-- SELECT 
--     MAX(salary) AS max_salary,
--     MIN(salary) AS min_salary,
--     SUM(salary) AS total_payroll
-- FROM employees;



-- -- Part 5

-- SELECT employee_id, first_name || ' ' || last_name as full_name, salary FROM employees WHERE salary > 65000
-- UNION
-- SELECT employee_id, first_name || ' ' || last_name as full_name, salary FROM employees WHERE hire_date > ' 2020-01-01';

-- SELECT * FROM employees WHERE department = 'IT'
-- INTERSECT
-- SELECT * FROM employees WHERE salary > 65000;


-- Part 6

-- SELECT 
--     e.employee_id,
--     e.first_name
-- FROM employees e
-- WHERE EXISTS (
--     SELECT 1
--     FROM projects p
--     WHERE p.project_id = e.employee_id
-- );


-- SELECT 
--     e.employee_id,
--     e.first_name
-- FROM employees e
-- WHERE e.employee_id IN (
--     SELECT pa.project_id
--     FROM projects pa
--     JOIN projects p ON pa.project_id = p.project_id
--     WHERE p.status = 'Active'
-- );

-- SELECT 
--     employee_id,
--     first_name,
--     salary
-- FROM employees
-- WHERE salary > ANY (
--     SELECT salary
--     FROM employees
--     WHERE department = 'Sales'
-- );


-- Part 7


-- SELECT 
--     e.department,
--     COUNT(e.employee_id) AS total_employees,
--     ROUND(AVG(e.salary), 2) AS average_salary,
    
    
--     (
--         SELECT first_name || ' ' || last_name
--         FROM employees e2
--         WHERE e2.department = e.department
--         ORDER BY e2.salary DESC
--         LIMIT 1
--     ) AS highest_paid_employee,
    
   
--     GREATEST(MAX(e.salary), AVG(e.salary)) AS salary_upper_metric,
--     LEAST(MIN(e.salary), AVG(e.salary)) AS salary_lower_metric

-- FROM employees e
-- GROUP BY e.department
-- ORDER BY average_salary DESC;









