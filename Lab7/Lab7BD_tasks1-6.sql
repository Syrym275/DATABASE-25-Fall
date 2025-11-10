
-- -- Part 1
-- -- Create table: employees
--  CREATE TABLE employees (
--     emp_id INT PRIMARY KEY,
--     emp_name VARCHAR(50),
--     dept_id INT,
--     salary DECIMAL(10, 2)
--  );

-- -- Create table: departments
--  CREATE TABLE departments (
--     dept_id INT PRIMARY KEY,
--     dept_name VARCHAR(50),
--     location VARCHAR(50)
--  );-- Create table: projects
--  CREATE TABLE projects (
--     project_id INT PRIMARY KEY,
--     project_name VARCHAR(50),
--     dept_id INT,
--     budget DECIMAL(10, 2)
--  );

-- -- Insert data into employees
--  INSERT INTO employees (emp_id, emp_name, dept_id, salary)
-- VALUES
--  (1, 'John Smith', 101, 50000),
--  (2, 'Jane Doe', 102, 60000),
--  (3, 'Mike Johnson', 101, 55000),
--  (4, 'Sarah Williams', 103, 65000),
--  (5, 'Tom Brown', NULL, 45000);-- Insert data into departments
-- INSERT INTO departments (dept_id, dept_name, location) VALUES
--  (101, 'IT', 'Building A'),
--  (102, 'HR', 'Building B'),
--  (103, 'Finance', 'Building C'),
--  (104, 'Marketing', 'Building D');-- Insert data into projects
--  INSERT INTO projects (project_id, project_name, dept_id,
-- budget) VALUES
--  (1, 'Website Redesign', 101, 100000),
--  (2, 'Employee Training', 102, 50000),
--  (3, 'Budget Analysis', 103, 75000),
--  (4, 'Cloud Migration', 101, 150000),
--  (5, 'AI Research', NULL, 200000);


-- SELECT * FROM departments;


-- -- Part 2

-- -- 2.1
-- CREATE VIEW employee_details AS
-- 	SELECT e.emp_name, e.salary, d.dept_name, d.location
-- 	FROM employees e 
-- 	JOIN departments d
-- 		ON e.dept_id = d.dept_id
-- 	WHERE e.dept_id IS NOT NULL;

 -- SELECT * FROM employee_details;
-- 4 rows, because Tom Brown has a NULL dept_id, we only print out those who are assigned to a department


-- -- 2.2

-- CREATE VIEW dept_statistics AS
--  SELECT d.dept_name, COUNT(emp_id) AS emp_cnt, AVG(salary) AS avg_salary,
--   MAX(salary) AS max_salary, MIN(salary) AS min_salary
--  FROM departments d
--  JOIN employees e ON d.dept_id = e.dept_id
--  GROUP BY d.dept_id;

-- SELECT * FROM dept_statistics
--  ORDER BY emp_cnt DESC;

-- -- 2.3

-- CREATE VIEW  project_overview AS
-- SELECT p.project_name, p.budget, d.dept_name, d.location,
-- COUNT(emp_id) AS team_size
-- FROM projects p
-- JOIN departments d
--     ON p.dept_id = d.dept_id 
-- LEFT JOIN employees e
--     ON d.dept_id = e.dept_id
-- GROUP BY
--     p.project_name, p.budget, d.dept_name, d.location;


-- SELECT * FROM project_overview;

-- -- 2.4
-- CREATE VIEW high_earners AS 
--  SELECT e.emp_name, e.salary, d.dept_name
--  FROM employees e
--  JOIN departments d ON e.dept_id = d.dept_id
--  WHERE salary > 55000;

-- SELECT * FROM high_earners;

-- returns 2 rows Doe and Williams earning 60k and 65k repsectively


-- -- Part 3

-- -- 3.1
-- CREATE OR REPLACE VIEW employee_details AS
-- SELECT e.emp_name, e.salary, d.dept_name, d.location,
-- CASE
-- 	WHEN e.salary > 60000 THEN 'High'
-- 	WHEN e.salary > 50000 AND e.salary < 600000 THEN 'Medium'
-- 	ELSE 'Standart'
-- END AS salary_grade
-- FROM employees e
-- JOIN departments d ON e.dept_id = d.dept_id
-- WHERE e.dept_id IS NOT NULL;

-- SELECT * FROM employee_details;


-- -- 3.2
-- ALTER VIEW  high_earners
-- 	RENAME TO top_performers;
-- SELECT * FROM top_performers;


-- -- 3.3
-- CREATE TEMPORARY VIEW temp_view AS
-- SELECT emp_name, salary, dept_id
-- FROM employees
-- WHERE salary < 50000;

-- SELECT * FROM temp_view;
-- DROP VIEW temp_view;



-- -- Part 4
-- -- 4.1
-- CREATE VIEW  employee_salaries AS 
-- SELECT emp_id, emp_name, dept_id, salary
-- FROM employees
-- SELECT * FROM employee_salaries

-- -- 4.2
-- UPDATE employee_salaries
-- SET salary = 52000
-- WHERE emp_name = 'John Smith';

-- SELECT * FROM employees WHERE emp_name = 'John Smith';
-- Yes it did.


-- 4.3
-- INSERT INTO employee_salaries VALUES (6, 'Alice Johnson', 102, 58000); 
-- SELECT * FROM employees
-- Yes it was.


-- -- 4.4
-- CREATE VIEW  it_employees AS 
-- SELECT * FROM employees
-- WHERE dept_id = 101
-- WITH LOCAL CHECK OPTION;

-- INSERT INTO it_employees (emp_id, emp_name, dept_id, salary)
--  VALUES (7, 'Bob Wilson', 103, 60000);
--  новая строка нарушает ограничение-проверку для представления "it_employees"
-- As the view only shows the it employees with dept_id = 101, it can't insert an employee from another department


-- -- Part 5
-- -- 5.1
-- CREATE MATERIALIZED VIEW dept_summary_mv AS
-- SELECT d.dept_id, d.dept_name,
-- COUNT(e.emp_id) AS team_size,
-- COALESCE(SUM(e.salary), 0) AS total_salary,
-- COUNT(p.project_id) as project_cnt,
-- COALESCE(SUM(p.budget), 0) AS total_budget
-- FROM departments d
-- JOIN projects p
--     ON d.dept_id = p.dept_id 
-- LEFT JOIN employees e
--     ON d.dept_id = e.dept_id
-- GROUP BY
--     d.dept_id, d.dept_name
-- WITH DATA;

 -- SELECT * FROM dept_summary_mv ORDER BY team_size DESC;

-- 5.2
-- INSERT INTO employees VALUES (8, 'Charlie Brown', 101, 54000);
 -- SELECT * FROM dept_summary_mv ORDER BY team_size DESC;
 -- REFRESH MATERIALIZED VIEW dept_summary_mv;
  -- SELECT * FROM dept_summary_mv ORDER BY team_size DESC;
-- The team size for IT department is increased after refreshing

-- -- 5.3
-- CREATE UNIQUE INDEX _dept_summary_idx ON dept_summary_mv(dept_id);
-- REFRESH MATERIALIZED VIEW CONCURRENTLY dept_summary_mv;
-- Users can continue reading the view when refreshing concurrently

-- -- 5.4

-- CREATE MATERIALIZED VIEW project_stats_mv AS
-- SELECT p.project_name, p.budget, d.dept_name,
-- COUNT(e.emp_id) AS project_team_size
-- FROM projects p
-- JOIN departments d
--     ON p.dept_id = d.dept_id 
-- LEFT JOIN employees e
--     ON p.dept_id = e.dept_id
-- GROUP BY
--     p.project_name, p.budget, d.dept_name
-- WITH NO DATA;
-- SELECT * FROM project_stats_mv;
-- Because we created it without inserting the actual data.

-- REFRESH MATERIALIZED VIEW project_stats_mv;
-- SELECT * FROM project_stats_mv;


-- -- Part 6
-- -- 6.1
-- CREATE ROLE analyst;
-- CREATE ROLE data_viewer
--     LOGIN
--     PASSWORD 'viewer123';
-- CREATE USER report_user
--     PASSWORD 'report456';
-- SELECT rolname FROM pg_roles WHERE rolname NOT LIKE 'pg_%';

-- -- 6.2
-- CREATE ROLE db_creator
--     LOGIN
--     CREATEDB
--     PASSWORD 'creator789';
-- CREATE ROLE user_manager
--     LOGIN
--     CREATEROLE
--     PASSWORD 'manager101';
-- CREATE ROLE admin_user
--     LOGIN
--     SUPERUSER
--     PASSWORD 'admin999';

-- -- 6.3
-- GRANT SELECT ON employees TO analyst;
-- GRANT SELECT ON departments TO analyst;
-- GRANT SELECT ON projects TO analyst;
-- GRANT ALL PRIVILEGES ON employee_details TO data_viewer;
-- GRANT SELECT, INSERT ON employees TO report_user;


-- -- 6.4
-- CREATE ROLE hr_team;
-- CREATE ROLE finance_team;
-- CREATE ROLE it_team;

-- CREATE USER hr_user1 PASSWORD 'hr001';
-- CREATE USER hr_user2 PASSWORD 'hr002';
-- CREATE USER finance_user1 PASSWORD 'fin001';

-- GRANT hr_team TO hr_user1;
-- GRANT hr_team TO hr_user2;
-- GRANT finance_team TO finance_user1;

-- GRANT SELECT, UPDATE ON employees TO hr_team;
-- GRANT SELECT ON dept_statistics TO finance_team;


-- -- 6.5
-- REVOKE UPDATE ON employees FROM hr_team;
-- REVOKE hr_team FROM hr_user2;
-- REVOKE ALL PRIVILEGES ON employee_details FROM data_viewer;

-- -- 6.6
-- ALTER ROLE analyst
--     LOGIN
--     PASSWORD 'analyst123';

-- ALTER ROLE user_manager
--     SUPERUSER;
-- ALTER ROLE analyst
--     PASSWORD NULL;
-- ALTER ROLE data_viewer
--     CONNECTION LIMIT 5;



