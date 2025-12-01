 -- -- Independent tasks

--  -- 1
-- BEGIN;

-- DO $$
-- DECLARE
--     bob_balance DECIMAL(10,2);
-- BEGIN
--     -- Get Bob's balance
--     SELECT balance INTO bob_balance
--     FROM accounts
--     WHERE name = 'Bob'
--     FOR UPDATE;  -- lock Bob's row to prevent concurrent updates

--     -- Check if Bob has enough funds
--     IF bob_balance < 200 THEN
--         RAISE EXCEPTION 'Insufficient funds: Bob has only %', bob_balance;
--     END IF;

--     -- Deduct from Bob
--     UPDATE accounts
--     SET balance = balance - 200
--     WHERE name = 'Bob';

--     -- Add to Wally
--     UPDATE accounts
--     SET balance = balance + 200
--     WHERE name = 'Wally';

-- END;
-- $$;

-- COMMIT;

SELECT * FROM accounts;

-- -- 2

-- BEGIN;

-- INSERT INTO products (shop, product, price)
-- VALUES ('Joe''s Shop', 'Peach Juice', 3.00);

-- SAVEPOINT sp1;

-- UPDATE products
-- SET price = 3.50
-- WHERE shop = 'Joe''s Shop' AND product = 'Peach Juice';

-- SAVEPOINT sp2;

-- DELETE FROM products
-- WHERE shop = 'Joe''s Shop' AND product = 'Peach Juice';

-- ROLLBACK TO SAVEPOINT sp1;

-- COMMIT;


-- -- 3
-- BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- SELECT balance FROM accounts WHERE name = 'SharedAccount';

-- UPDATE accounts
-- SET balance = balance - 400
-- WHERE name = 'SharedAccount' AND balance >= 400;

-- COMMIT;

-- ----------------------
-- BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- SELECT balance FROM accounts WHERE name = 'SharedAccount';

-- UPDATE accounts
-- SET balance = balance - 400
-- WHERE name = 'SharedAccount' AND balance >= 400;

-- COMMIT;

 -- no isolation level will make the account go negative due to the WHERE check
 -- but read committed works best for such cases


--  -- 4

--  CREATE TABLE Sells (
--     shop VARCHAR(50),
--     product VARCHAR(50),
--     price DECIMAL(10,2)
-- );

-- INSERT INTO Sells VALUES
-- ('Joe''s Shop', 'Coke', 2.00),
-- ('Joe''s Shop', 'Pepsi', 2.50),
-- ('Joe''s Shop', 'Fanta', 3.00);


-- BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- SELECT MAX(price) FROM Sells WHERE shop = 'Joe''s Shop';

-- SELECT MIN(price) FROM Sells WHERE shop = 'Joe''s Shop';

-- COMMIT;
