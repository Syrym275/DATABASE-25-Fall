-- Part 1
-- 1.1

-- CREATE DATABASE university_main
-- 	OWNER postgres
-- 	TEMPLATE template0
-- 	ENCODING UTF8;

-- CREATE DATABASE university_archive
-- 	CONNECTION LIMIT = 50
-- 	TEMPLATE template0;

-- CREATE DATABASE university_test
-- 	WITH is_template = TRUE
-- 	CONNECTION LIMIT = 10;

-- SELECT datname, datistemplate 
-- FROM pg_database
-- WHERE datname = 'university_test';


-- 1.2

CREATE TABLESPACE student_data
	LOCATION 'C:\data\students'
	






	

