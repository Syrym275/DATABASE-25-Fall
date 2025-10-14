-- Part 1

-- -- 1.1
-- CREATE TABLE employees(
-- 	employee_id INT,
-- 	first_name VARCHAR(20),
-- 	last_name VARCHAR(20),
-- 	age INT CHECK(age BETWEEN 18 AND 65),
-- 	salary NUMERIC CHECK(salary > 0)
-- );

-- -- 1.2
-- CREATE TABLE products_catalog (
--     product_id      INTEGER,
--     product_name    TEXT,
--     regular_price   NUMERIC,
--     discount_price  NUMERIC
-- 	CONSTRAINT valid_discount CHECK(
-- 		regular_price > 0 AND
-- 		discount_price > 0 AND
-- 		discount_price < regular_price
-- 	)
-- );

-- -- 1.3
-- CREATE TABLE bookings (
--     booking_id      INTEGER,
--     check_in_date   DATE,
--     check_out_date  DATE,
--     num_guests      INTEGER
-- );

-- ALTER TABLE bookings
-- ADD CONSTRAINT valid_date CHECK(
-- 	num_guests > 0 AND num_guests < 11 AND
-- 	check_out_date > check_in_date
-- );

-- -- 1.4
-- INSERT INTO employees (employee_id, first_name, last_name, age, salary)
-- VALUES 
--     (1, 'Alice', 'Johnson', 30, 4500.00),
-- 	(2, 'Conor', 'Macgregor', 88, 1000000),
--     (3, 'Bob', 'Smith', 45, 6000.00);

-- INSERT INTO products_catalog (product_id, product_name, regular_price, discount_price)
-- VALUES
--     (1, 'Wireless Mouse', 25.00, 19.99),
--     (2, 'Mechanical Keyboard', 80.00, 65.00);

-- INSERT INTO products_catalog (product_id, product_name, regular_price, discount_price)
-- VALUES
--     (2, 'Mechanical Keyboard', 80.00, 95.00);


-- INSERT INTO bookings (booking_id, check_in_date, check_out_date, num_guests)
-- VALUES
--     (1, DATE '2025-11-01', DATE '2025-11-05', 2),
--     (2, DATE '2025-12-15', DATE '2025-12-20', 4);

-- INSERT INTO bookings (booking_id, check_in_date, check_out_date, num_guests)
-- VALUES
--     (3, DATE '2025-12-15', DATE '2025-12-20', 18);



-- Part 2

-- -- 2.1
-- CREATE TABLE customers (
--     customer_id INTEGER NOT NULL,
--     email TEXT NOT NULL,
--     phone TEXT,
--     registration_date DATE NOT NULL
-- );

-- -- 2.2
-- CREATE TABLE inventory (
--     item_id INTEGER NOT NULL,
--     item_name TEXT NOT NULL,
--     quantity INTEGER NOT NULL CHECK (quantity >= 0),
--     unit_price NUMERIC NOT NULL CHECK (unit_price > 0),
--     last_updated TIMESTAMP NOT NULL
-- );

-- -- 2.3
-- INSERT INTO customers (customer_id, email, phone, registration_date)
-- VALUES (1, 'jane.doe@example.com', '555-1234', DATE '2025-10-13');
-- INSERT INTO customers (customer_id, phone, registration_date)
-- VALUES (1, '555-1234', DATE '2025-10-13');
-- INSERT INTO customers (customer_id, email, registration_date)
-- VALUES (1, 'jane.doe@example.com', DATE '2025-10-13');

-- INSERT INTO inventory (item_id, quantity, unit_price, last_updated)
-- VALUES (1, 25, 39.99, TIMESTAMP '2025-10-13 10:30:00');


-- Part 3

-- -- 3.1
-- CREATE TABLE users (
--     user_id INTEGER,
--     username TEXT UNIQUE,
--     email TEXT UNIQUE,
--     created_at TIMESTAMP
-- );

-- 3.2
-- CREATE TABLE course_enrollments (
--     enrollment_id INTEGER,
--     student_id INTEGER,
--     course_code TEXT,
--     semester TEXT
-- );

-- ALTER TABLE course_enrollments
-- ADD CONSTRAINT unique_vals UNIQUE(student_id, course_code, 
-- semester)

-- -- 3.3
-- ALTER TABLE users
-- ADD CONSTRAINT unique_username UNIQUE (username);

-- ALTER TABLE users
-- ADD CONSTRAINT unique_email UNIQUE (email);



-- -- Part 4

-- 4.1
-- CREATE TABLE departments (
--     dept_id INTEGER PRIMARY KEY,
--     dept_name TEXT NOT NULL,
--     location TEXT
-- );

-- INSERT INTO departments(dept_id, location)
-- VALUES
-- (1, 'LA'),
-- (1, 'NYC')

-- -- 4.2
-- CREATE TABLE student_courses (
--     student_id INTEGER,
--     course_id INTEGER,
--     enrollment_date DATE,
--     grade TEXT,
-- 	PRIMARY KEY(student_id, course_id)
-- );

-- -- 4.3
-- /*
--  1.UNIQUE can allow multiple NULL values, each NULL cells is considered unique
-- PRIMARY KEY can be only one column or composite, UNIQUE can be every column
-- PRIMARY KEY mostly used for creating relationships between tables

--  2. COMPOSITE PROMARY KEY is mostly used when single column isn't enough for uniqueness identity
--  For example: one student can take multiple courses so the table needs to have student_id and 
--  course_id combined as a primary key 

--  3. Because the primary key uniquely identifies each row,
-- while UNIQUE constraints just enforce uniqueness on additional columns.
-- */


-- -- Part 5

-- -- 5.1
-- CREATE TABLE employees_dept (
--     emp_id INTEGER PRIMARY KEY,
--     emp_name TEXT NOT NULL,
--     hire_date DATE,
--  dept_id INT REFERENCES departments(dept_id)
-- );

-- INSERT INTO departments (dept_id, dept_name, location)
-- VALUES
--     (1, 'HR', 'New York'),
--     (2, 'IT', 'London'),
--     (3, 'Finance', 'Paris');

-- INSERT INTO employees_dept (emp_id, emp_name, hire_date, dept_id)
-- VALUES
--     (101, 'Alice', '2022-01-15', 1),
--     (102, 'Bob', '2023-03-10', 2),
--     (103, 'Charlie', '2024-06-25', 3);

-- INSERT INTO employees_dept (emp_id, emp_name, hire_date, dept_id)
-- VALUES
--     (104, 'David', '2024-07-01', 5);


-- -- 5.2

-- CREATE TABLE authors (
--     author_id INTEGER PRIMARY KEY,
--     author_name TEXT NOT NULL,
--     country TEXT
-- );

-- CREATE TABLE publishers (
--     publisher_id INTEGER PRIMARY KEY,
--     publisher_name TEXT NOT NULL,
--     city TEXT
-- );

-- CREATE TABLE books (
--     book_id INTEGER PRIMARY KEY,
--     title TEXT NOT NULL,
--     author_id INTEGER REFERENCES authors(author_id),
--     publisher_id INTEGER REFERENCES publishers(publisher_id),
--     publication_year INTEGER,
--     isbn TEXT UNIQUE
-- );

-- -- 5.3

-- CREATE TABLE categories (
--     category_id INTEGER PRIMARY KEY,
--     category_name TEXT NOT NULL
-- );

-- CREATE TABLE products_fk (
--     product_id INTEGER PRIMARY KEY,
--     product_name TEXT NOT NULL,
--     category_id INTEGER REFERENCES categories(category_id) ON DELETE RESTRICT
-- );

-- CREATE TABLE orders (
--     order_id INTEGER PRIMARY KEY,
--     order_date DATE NOT NULL
-- );


-- CREATE TABLE order_items (
--     item_id INTEGER PRIMARY KEY,
--     order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE,
--     product_id INTEGER REFERENCES products_fk(product_id),
--     quantity INTEGER CHECK (quantity > 0)
-- );

-- INSERT INTO categories (category_id, category_name)
-- VALUES
--     (1, 'Electronics'),
--     (2, 'Clothing');

-- INSERT INTO products_fk (product_id, product_name, category_id)
-- VALUES
--     (101, 'Laptop', 1),
--     (102, 'T-Shirt', 2);

-- INSERT INTO orders (order_id, order_date)
-- VALUES
--     (1001, '2025-10-01'),
--     (1002, '2025-10-02');

-- INSERT INTO order_items (item_id, order_id, product_id, quantity)
-- VALUES
--     (1, 1001, 101, 2),
--     (2, 1002, 102, 3);

-- -- error, because it restricts deletion from the child table
-- DELETE FROM categories
-- WHERE category_id = 1;

-- -- deletes the row from both tables
-- DELETE FROM orders 
-- WHERE order_id = 1;


-- CREATE DATABASE university_main2
-- 	OWNER postgres
-- 	TEMPLATE template0
-- 	ENCODING UTF8;