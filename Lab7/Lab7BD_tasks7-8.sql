-- -- Part 7
-- -- 7.1
-- CREATE ROLE read_only;
-- GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only;

-- CREATE ROLE junior_analyst PASSWORD 'junior123';
-- CREATE ROLE senior_analyst PASSWORD 'senior123';

-- GRANT read_only TO junior_analyst;
-- GRANT read_only TO senior_analyst;

-- GRANT INSERT, UPDATE ON employees TO senior_analyst; 


-- -- 7.2
-- CREATE ROLE  project_manager LOGIN PASSWORD 'pm123';
-- ALTER VIEW dept_statistics OWNER TO project_manager;
-- ALTER TABLE projects OWNER TO project_manager;

-- SELECT tablename, tableowner 
-- FROM pg_tables 
-- WHERE schemaname = 'public';

-- -- 7.3
-- CREATE ROLE temp_owner LOGIN;
-- CREATE TEMP TABLE temp_table (
--     id INT
-- );
-- ALTER TABLE temp_table OWNER TO  temp_owner;
-- REASSIGN OWNED BY temp_owner TO postgres;
-- DROP OWNED BY temp_owner; -- drop all objects
-- DROP ROLE temp_owner; 


-- -- 7.4
-- CREATE VIEW hr_employee_view AS
-- 		SELECT emp_name
-- 		FROM employees
-- 		WHERE dept_id = 102;

-- GRANT SELECT ON hr_employee_view TO hr_team;

-- CREATE VIEW finance_employee_view AS
-- 	SELECT  emp_id, emp_name, salary
-- 	FROM employees;

-- GRANT SELECT ON finance_employee_view TO  finance_team;

 
-- -- Part 8
-- -- 8.1
-- CREATE OR REPLACE VIEW dept_dashboard AS
-- SELECT
--     d.dept_name, d.location,
-- 	COUNT(e.emp_id) AS employee_cnt,
-- 	ROUND(AVG(e.salary)::numeric, 2) AS avg_salary,
-- 	COUNT(DISTINCT p.project_id) AS active_projects,
-- 	COALESCE(SUM(p.budget), 0) AS total_budget,
-- 	ROUND(
--         COALESCE(SUM(p.budget), 0)::numeric /
--         NULLIF(COUNT(DISTINCT e.emp_id), 0),
--         2
--     ) AS budget_per_employee
-- FROM departments d
-- JOIN employees e ON d.dept_id = e.dept_id
-- LEFT JOIN projects p
--     ON d.dept_id = p.dept_id
-- GROUP BY d.dept_name, d.location;
	

-- -- 8.2
-- ALTER TABLE projects
-- ADD COLUMN created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- CREATE VIEW high_budget_projects AS
-- 	SELECT p.project_name, p.budget, d.dept_name, p.created_date
-- FROM projects p
-- JOIN departments d ON d.dept_id = p.dept_id
-- WHERE p.budget > 75000;

-- CREATE OR REPLACE VIEW high_budget_projects AS
-- SELECT
--     p.project_name,
--     p.budget,
--     d.dept_name,
--     p.created_date,

--     CASE
--         WHEN p.budget > 150000 THEN 'Critical Review Required'
--         WHEN p.budget > 100000 THEN 'Management Approval Needed'
--         ELSE 'Standard Process'
--     END AS approval_status

-- FROM projects p
-- JOIN departments d
--     ON p.dept_id = d.dept_id
-- WHERE p.budget > 75000;


-- -- 8.3
-- -- level 1
-- CREATE ROLE viewer_role;
-- GRANT SELECT ON ALL TABLES IN SCHEMA public TO viewer_role;

-- -- level 2
-- CREATE ROLE  entry_role;
-- GRANT viewer_role TO entry_role;
-- GRANT INSERT ON employees TO entry_role;
-- GRANT INSERT ON projects  TO entry_role;

-- -- level 3
-- CREATE ROLE  analyst_role;
-- GRANT entry_role TO analyst_role;
-- GRANT UPDATE ON employees TO analyst_role;
-- GRANT UPDATE ON projects  TO analyst_role;

-- -- level 4
-- CREATE ROLE manager_role;
-- GRANT analyst_role TO manager_role;
-- GRANT DELETE ON employees TO manager_role;
-- GRANT DELETE ON projects  TO manager_role;

-- CREATE USER alice PASSWORD 'alice123';
-- CREATE USER bob PASSWORD 'bob123';
-- CREATE USER charlie PASSWORD 'charlie123';

-- GRANT viewer_role TO alice;
-- GRANT analyst_role TO bob;
-- GRANT manager_role TO charlie;