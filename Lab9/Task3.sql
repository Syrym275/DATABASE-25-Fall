-- -- Lab 10
-- -- 3.1
-- CREATE TABLE accounts (
--     id SERIAL PRIMARY KEY,
--     name VARCHAR(100) NOT NULL,
--     balance DECIMAL(10, 2) DEFAULT 0.00
--  );
--  CREATE TABLE products (
--     id SERIAL PRIMARY KEY,
--     shop VARCHAR(100) NOT NULL,
--     product VARCHAR(100) NOT NULL,
--     price DECIMAL(10, 2) NOT NULL
--  );

 -- INSERT INTO accounts (name, balance) VALUES
 --    ('Alice', 1000.00),
 --    ('Bob', 500.00),
 --    ('Wally', 750.00);
 -- INSERT INTO products (shop, product, price) VALUES
 --    ('Joe''s Shop', 'Coke', 2.50),
 --    ('Joe''s Shop', 'Pepsi', 3.00);


-- 3.2
 -- BEGIN;
 -- UPDATE accounts SET balance = balance - 100.00
 --    WHERE name = 'Alice';
 -- UPDATE accounts SET balance = balance + 100.00
 --    WHERE name = 'Bob';
 -- COMMIT;

/*
a) it's changed same way sa in the transaction
b) to prevent errors and keep consistency of the DB.
c) if one part craches, te whole transaction won't be executed.
*/

-- -- 3.3
--  BEGIN;
--  UPDATE accounts SET balance = balance - 500.00
--     WHERE name = 'Alice';
--  SELECT * FROM accounts WHERE name = 'Alice';-- Oops! Wrong amount, let's undo
--  ROLLBACK;
--  SELECT * FROM accounts WHERE name = 'Alice';

/*
a) it was 400
b) it is set back to 900
c) when there are no enough money on the bank account
*/


-- -- 3.4
-- BEGIN;
--  UPDATE accounts SET balance = balance - 100.00
--     WHERE name = 'Alice';
--  SAVEPOINT my_savepoint;
-- UPDATE accounts SET balance = balance + 100.00
--     WHERE name = 'Bob';-- Oops, should transfer to Wally instead
--  ROLLBACK TO my_savepoint;
--  UPDATE accounts SET balance = balance + 100.00
--     WHERE name = 'Wally';
--  COMMIT;


 /*
a) 800, 600 and 850
b) yes, but it was rolled back right away
c) because we didn't need to undo all the transactions,
we only needed on of them to be rolled back
 */

 -- 3.5

 /*
a) it sees the original table before and the updated one after
b) it sees the old data only.
c) Even though Terminal 2 committed, Terminal 1’s isolation level forces it to see only the snapshot from the start of the transaction.
 */


 -- 3.6
/*
a) no, All SELECTs see the same snapshot taken at the moment the first query in the transaction runs.
b) it is when somw updates occur in between SELECT queries
c) repeatable read amd serializied
*/

-- 3.7
/*
a) no, it never reads uncommited data
b) when you read something that is rolled back right away
c) to keep the data consistent and avoid reading false queries that will be rolled back right away
*/


