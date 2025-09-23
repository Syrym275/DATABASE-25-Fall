-- Part 2

-- SELECT current_database();
-- DROP TABLE students

-- -- 2.1
-- CREATE TABLE students (
--     student_id SERIAL PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name  VARCHAR(50),
-- 	email VARCHAR(100),
-- 	phone CHAR(15),
-- 	date_of_birth DATE,
-- 	enrollment_date DATE,
-- 	gpa DECIMAL(3, 2),
-- 	is_active BOOL,
-- 	graduation_year SMALLINT
-- );

-- CREATE TABLE professors (
--     professor_id SERIAL PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name  VARCHAR(50),
-- 	email VARCHAR(100),
-- 	office_number VARCHAR(20),
-- 	hire_date DATE,
-- 	salary DECIMAL(10, 2),
-- 	is_tenured BOOL,
-- 	years_experience INT
-- );


-- CREATE TABLE courses (
--     course_id SERIAL PRIMARY KEY,
--     course_code CHAR(8),
-- 	course_title VARCHAR(100),
-- 	description TEXT,
-- 	credits SMALLINT,
-- 	max_enrollment INT,
-- 	course_fee DECIMAL(7, 2),
-- 	is_online BOOL,
-- 	created_at TIMESTAMP 
-- );


-- -- 2.2

-- CREATE TABLE class_schedule (
--     schedule_id SERIAL PRIMARY KEY,
--     course_id INTEGER,
--     professor_id INTEGER,
--     classroom VARCHAR(20),
--     class_date DATE,
--     start_time TIME WITHOUT TIME ZONE,
--     end_time TIME WITHOUT TIME ZONE,
--     duration INTERVAL
-- );

-- ALTER TABLE class_schedule
-- ADD UNIQUE(course_id);

-- CREATE TABLE student_records (
--     record_id SERIAL PRIMARY KEY,
--     student_id INTEGER,
--     course_id INTEGER REFERENCES class_schedule(course_id),
--     semester VARCHAR(20),
--     year INTEGER,
--     grade CHAR(2),
--     attendance_percentage DECIMAL(4,1),
--     submission_timestamp TIMESTAMP WITHOUT TIME ZONE,
-- 	last_updated TIMESTAMP WITHOUT TIME ZONE
-- );


-- -- Part 3

-- -- 3.1

-- ALTER TABLE students
-- 	ADD COLUMN middle_name VARCHAR(30),
-- 	ADD COLUMN student_status VARCHAR(20),
-- 	ALTER COLUMN phone SET DATA TYPE VARCHAR(20),
-- 	ALTER COLUMN gpa SET DEFAULT 0.00;

-- UPDATE students
-- SET student_status = 'ACTIVE'
-- WHERE student_status IS NULL;


-- ALTER TABLE professors
--     ADD COLUMN department_code CHAR(5),
--     ADD COLUMN research_area TEXT,
--     ALTER COLUMN years_experience TYPE SMALLINT,
--     ALTER COLUMN is_tenured SET DEFAULT FALSE,
--     ADD COLUMN last_promotion_date DATE;


-- ALTER TABLE courses
--     ADD COLUMN prerequisite_course_id INTEGER,
--     ADD COLUMN difficulty_level SMALLINT,
--     ALTER COLUMN course_code TYPE VARCHAR(10),
--     ALTER COLUMN credits SET DEFAULT 3,
--     ADD COLUMN lab_required BOOLEAN DEFAULT FALSE;


-- -- 3.2

-- ALTER TABLE class_schedule
-- 	ADD COLUMN room_capacity INTEGER,
-- 	DROP COLUMN duration,
--     ADD COLUMN session_type VARCHAR(15),
--     ALTER COLUMN classroom TYPE VARCHAR(30),
--     ADD COLUMN equipment_needed TEXT;
	

-- ALTER TABLE student_records
-- 	ADD COLUMN extra_credit_points DECIMAL(4,1) DEFAULT 0.0,
--     ALTER COLUMN grade TYPE VARCHAR(5),
--     ADD COLUMN final_exam_date DATE,
--     DROP COLUMN last_updated;
	


-- -- Part 4

-- -- 4.1

-- CREATE TABLE departments(
-- 	department_id SERIAL PRIMARY KEY,
-- 	department_name VARCHAR(100),
--     department_code CHAR(5),
--     building VARCHAR(50),
--     phone VARCHAR(15),
--     budget DECIMAL(15,2),
--     established_year INTEGER
-- );

-- CREATE TABLE library_books (
--     book_id SERIAL PRIMARY KEY,
--     isbn CHAR(13),
--     title VARCHAR(200),
--     author VARCHAR(100),
--     publisher VARCHAR(100),
--     publication_date DATE,
--     price DECIMAL(10,2),
--     is_available BOOLEAN,
--     acquisition_timestamp TIMESTAMP WITHOUT TIME ZONE
-- );

-- CREATE TABLE student_book_loans (
--     loan_id SERIAL PRIMARY KEY,
--     student_id INTEGER,
--     book_id INTEGER,
--     loan_date DATE,
--     due_date DATE,
--     return_date DATE,
--     fine_amount DECIMAL(10,2),
--     loan_status VARCHAR(20)
-- );


-- 4.2

-- ALTER TABLE professors
-- 	ADD COLUMN department_id INTEGER REFERENCES departments(department_id);

-- SELECT * FROM departments;

-- ALTER TABLE students
--     ADD COLUMN advisor_id INTEGER REFERENCES professors(professor_id);

-- ALTER TABLE courses
--     ADD COLUMN department_id INTEGER REFERENCES departments(department_id);

-- ALTER TABLE professors
-- ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);


-- CREATE TABLE grade_scale (
--     grade_id SERIAL PRIMARY KEY,
--     letter_grade CHAR(2),
--     min_percentage DECIMAL(3,1),
--     max_percentage DECIMAL(3,1),
--     gpa_points DECIMAL(3,2)
-- );


-- CREATE TABLE semester_calendar (
--     semester_id SERIAL PRIMARY KEY,
--     semester_name VARCHAR(20),
--     academic_year INTEGER,
--     start_date DATE,
--     end_date DATE,
--     registration_deadline TIMESTAMPTZ,
--     is_current BOOLEAN
-- );


-- -- Paart 5

-- -- 5.1

-- DROP TABLE IF EXISTS student_book_loans;
-- DROP TABLE IF EXISTS library_books;
-- DROP TABLE IF EXISTS grade_scale;

-- CREATE TABLE grade_scale (
--     grade_id SERIAL PRIMARY KEY,
--     letter_grade CHAR(2),
--     min_percentage DECIMAL(4,1),
--     max_percentage DECIMAL(4,1),
--     gpa_points DECIMAL(4,2),
--     description TEXT
-- );


-- DROP TABLE IF EXISTS semester_calendar CASCADE;


-- CREATE TABLE semester_calendar (
--     semester_id SERIAL PRIMARY KEY,
--     semester_name VARCHAR(20),
--     academic_year INTEGER,
--     start_date DATE,
--     end_date DATE,
--     registration_deadline TIMESTAMPTZ,
--     is_current BOOLEAN
-- );


-- 5.2



-- DROP DATABASE IF EXISTS university_test;
-- DROP DATABASE IF EXISTS university_distributed;


-- CREATE DATABASE university_backup
--     TEMPLATE university_main;







