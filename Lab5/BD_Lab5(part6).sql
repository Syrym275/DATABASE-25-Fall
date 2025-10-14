-- CREATE TABLE customers (
--     customer_id SERIAL PRIMARY KEY,
--     name TEXT NOT NULL,
--     email TEXT UNIQUE NOT NULL,
--     phone TEXT,
--     registration_date DATE NOT NULL
-- );

-- CREATE TABLE products (
--     product_id SERIAL PRIMARY KEY,
--     name TEXT NOT NULL,
--     description TEXT,
--     price NUMERIC(10,2) CHECK (price >= 0),
--     stock_quantity INTEGER CHECK (stock_quantity >= 0)
-- );

-- CREATE TABLE orders (
--     order_id SERIAL PRIMARY KEY,
--     customer_id INTEGER REFERENCES customers(customer_id) ON DELETE CASCADE,
--     order_date DATE NOT NULL,
--     total_amount NUMERIC(10,2) CHECK (total_amount >= 0),
--     status TEXT CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled'))
-- );

-- CREATE TABLE order_details (
--     order_detail_id SERIAL PRIMARY KEY,
--     order_id INTEGER REFERENCES orders(order_id) ON DELETE CASCADE,
--     product_id INTEGER REFERENCES products(product_id) ON DELETE RESTRICT,
--     quantity INTEGER CHECK (quantity > 0),
--     unit_price NUMERIC(10,2) CHECK (unit_price >= 0)
-- );


-- INSERT INTO customers (name, email, phone, registration_date)
-- VALUES
-- ('Alice Johnson', 'alice@example.com', '123-456-7890', '2025-01-10'),
-- ('Bob Smith', 'bob@example.com', '987-654-3210', '2025-02-05'),
-- ('Charlie Lee', 'charlie@example.com', '555-123-4567', '2025-03-01');

-- INSERT INTO products (name, description, price, stock_quantity)
-- VALUES
-- ('Laptop', '14-inch laptop with 16GB RAM and 512GB SSD', 950.00, 10),
-- ('Smartphone', '5G smartphone with 128GB storage', 700.00, 25),
-- ('Headphones', 'Noise-cancelling over-ear headphones', 120.00, 40),
-- ('Monitor', '27-inch 144Hz curved monitor', 300.00, 15),
-- ('Keyboard', 'Mechanical RGB gaming keyboard', 85.00, 50);

-- INSERT INTO orders (customer_id, order_date, total_amount, status)
-- VALUES
-- (1, '2025-10-01', 1350.00, 'pending'),
-- (2, '2025-10-02', 700.00, 'processing'),
-- (3, '2025-10-03', 120.00, 'shipped'),
-- (1, '2025-10-04', 385.00, 'delivered'),
-- (2, '2025-10-05', 950.00, 'cancelled');

