-- CREATE TABLE customers (
--     customer_id       SERIAL PRIMARY KEY,
--     iin               VARCHAR(12) UNIQUE NOT NULL,
--     full_name         VARCHAR(255) NOT NULL,
--     phone             VARCHAR(30),
--     email             VARCHAR(120),
--     status            VARCHAR(20) CHECK (status IN ('active', 'blocked', 'frozen')),
--     created_at        TIMESTAMP NOT NULL DEFAULT NOW(),
--     daily_limit_kzt   NUMERIC(18,2) DEFAULT 0
-- );

-- CREATE TABLE accounts (
--     account_id      SERIAL PRIMARY KEY,
--     customer_id     INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
--     account_number  VARCHAR(34) UNIQUE NOT NULL,      -- IBAN-like
--     currency        VARCHAR(3) CHECK (currency IN ('KZT','USD','EUR','RUB')),
--     balance         NUMERIC(18,2) DEFAULT 0,
--     is_active       BOOLEAN DEFAULT TRUE,
--     opened_at       TIMESTAMP NOT NULL DEFAULT NOW(),
--     closed_at       TIMESTAMP
-- );

-- CREATE INDEX idx_accounts_customer ON accounts(customer_id);


-- CREATE TABLE transactions (
--     transaction_id   SERIAL PRIMARY KEY,
--     from_account_id  INT REFERENCES accounts(account_id),
--     to_account_id    INT REFERENCES accounts(account_id),
--     amount           NUMERIC(18,2) NOT NULL,
--     currency         VARCHAR(3) CHECK (currency IN ('KZT','USD','EUR','RUB')),
--     exchange_rate    NUMERIC(18,6),
--     amount_kzt       NUMERIC(18,2),
--     type             VARCHAR(20) CHECK (type IN ('transfer','deposit','withdrawal')),
--     status           VARCHAR(20) CHECK (status IN ('pending','completed','failed','reversed')),
--     created_at       TIMESTAMP NOT NULL DEFAULT NOW(),
--     completed_at     TIMESTAMP,
--     description      TEXT
-- );



-- CREATE TABLE exchange_rates (
--     rate_id       SERIAL PRIMARY KEY,
--     from_currency VARCHAR(3) NOT NULL CHECK (from_currency IN ('KZT','USD','EUR','RUB')),
--     to_currency   VARCHAR(3) NOT NULL CHECK (to_currency IN ('KZT','USD','EUR','RUB')),
--     rate          NUMERIC(18,6) NOT NULL,
--     valid_from    TIMESTAMP NOT NULL,
--     valid_to      TIMESTAMP
-- );



-- CREATE TABLE audit_log (
--     log_id       SERIAL PRIMARY KEY,
--     table_name   VARCHAR(100) NOT NULL,
--     record_id    INT NOT NULL,
--     action       VARCHAR(10) CHECK (action IN ('INSERT','UPDATE','DELETE')),
--     old_values   JSONB,
--     new_values   JSONB,
--     changed_by   VARCHAR(100),
--     changed_at   TIMESTAMP NOT NULL DEFAULT NOW(),
--     ip_address   VARCHAR(50)
-- );


-- INSERT INTO customers (customer_id, iin, full_name, phone, email, status, created_at, daily_limit_kzt) VALUES
-- (1, '123456789012', 'LeBron James', '+1-310-555-1001', 'lebron@example.com', 'active', '2023-01-10', 200000),
-- (2, '223456789012', 'Stephen Curry', '+1-415-555-2002', 'curry@example.com', 'active', '2023-01-15', 150000),
-- (3, '323456789012', 'Kevin Durant', '+1-718-555-3003', 'durant@example.com', 'blocked', '2023-02-01', 100000),
-- (4, '423456789012', 'Giannis Antetokounmpo', '+1-414-555-4004', 'giannis@example.com', 'active', '2023-02-10', 180000),
-- (5, '523456789012', 'Nikola Jokic', '+1-303-555-5005', 'jokic@example.com', 'active', '2023-02-18', 220000),
-- (6, '623456789012', 'Luka Doncic', '+1-214-555-6006', 'luka@example.com', 'active', '2023-03-01', 160000),
-- (7, '723456789012', 'Kawhi Leonard', '+1-213-555-7007', 'kawhi@example.com', 'frozen', '2023-03-10', 120000),
-- (8, '823456789012', 'Damian Lillard', '+1-503-555-8008', 'dame@example.com', 'active', '2023-03-12', 140000),
-- (9, '923456789012', 'Joel Embiid', '+1-215-555-9009', 'embiid@example.com', 'active', '2023-03-20', 200000),
-- (10,'103456789012', 'Jayson Tatum', '+1-617-555-1010', 'tatum@example.com', 'active', '2023-03-25', 170000);


-- INSERT INTO accounts (account_id, customer_id, account_number, currency, balance, is_active, opened_at, closed_at) VALUES
-- (1, 1, 'KZ123BANK000000000001', 'KZT', 500000, true, '2023-01-10', NULL),
-- (2, 1, 'KZ123BANK000000000002', 'USD', 2000, true, '2023-01-11', NULL),

-- (3, 2, 'KZ123BANK000000000003', 'KZT', 350000, true, '2023-01-15', NULL),
-- (4, 2, 'KZ123BANK000000000004', 'EUR', 1500, true, '2023-01-16', NULL),

-- (5, 3, 'KZ123BANK000000000005', 'KZT', 10000, false, '2023-02-01', '2023-02-15'),
-- (6, 3, 'KZ123BANK000000000006', 'USD', 500, false, '2023-02-02', '2023-02-20'),

-- (7, 4, 'KZ123BANK000000000007', 'KZT', 800000, true, '2023-02-10', NULL),
-- (8, 4, 'KZ123BANK000000000008', 'USD', 1000, true, '2023-02-11', NULL),

-- (9, 5, 'KZ123BANK000000000009', 'KZT', 900000, true, '2023-02-18', NULL),
-- (10,5, 'KZ123BANK000000000010', 'EUR', 800, true, '2023-02-19', NULL),

-- (11,6, 'KZ123BANK000000000011', 'KZT', 400000, true, '2023-03-01', NULL),
-- (12,6, 'KZ123BANK000000000012', 'USD', 750, true, '2023-03-02', NULL),

-- (13,7, 'KZ123BANK000000000013', 'KZT', 50000, false, '2023-03-10', '2023-03-20'),
-- (14,7, 'KZ123BANK000000000014', 'EUR', 300, false, '2023-03-11', '2023-03-22'),

-- (15,8, 'KZ123BANK000000000015', 'KZT', 220000, true, '2023-03-12', NULL),
-- (16,8, 'KZ123BANK000000000016', 'USD', 450, true, '2023-03-13', NULL),

-- (17,9, 'KZ123BANK000000000017', 'KZT', 600000, true, '2023-03-20', NULL),
-- (18,9, 'KZ123BANK000000000018', 'USD', 900, true, '2023-03-21', NULL),

-- (19,10,'KZ123BANK000000000019', 'KZT', 300000, true, '2023-03-25', NULL),
-- (20,10,'KZ123BANK000000000020', 'EUR', 650, true, '2023-03-26', NULL);



-- INSERT INTO transactions (transaction_id, from_account_id, to_account_id, amount, currency, exchange_rate, amount_kzt, type, status, created_at, completed_at, description) VALUES
-- (1, 1, 3, 50000, 'KZT', 1, 50000, 'transfer', 'completed', '2023-04-01', '2023-04-01', 'LeBron to Curry'),
-- (2, 3, 1, 20000, 'KZT', 1, 20000, 'transfer', 'completed', '2023-04-02', '2023-04-02', 'Curry refund'),
-- (3, NULL, 1, 100000, 'KZT', 1, 100000, 'deposit', 'completed', '2023-04-03', '2023-04-03', 'Cash deposit'),
-- (4, 7, 9, 30000, 'KZT', 1, 30000, 'transfer', 'completed', '2023-04-04', '2023-04-04', 'Giannis to Jokic'),
-- (5, 11, NULL, 5000, 'KZT', 1, 5000, 'withdrawal', 'completed', '2023-04-05', '2023-04-05', 'ATM withdrawal'),
-- (6, 2, 4, 100, 'USD', 450, 45000, 'transfer', 'completed', '2023-04-06', '2023-04-06', 'USD transfer'),
-- (7, 8, 16, 50, 'USD', 450, 22500, 'transfer', 'completed', '2023-04-07', '2023-04-07', 'Giannis to Dame'),
-- (8, 12, 20, 70, 'USD', 450, 31500, 'transfer', 'failed', '2023-04-08', NULL, 'Insufficient funds'),
-- (9, NULL, 17, 200000, 'KZT', 1, 200000, 'deposit', 'completed', '2023-04-09', '2023-04-09', 'Deposit'),
-- (10, 15, 19, 15000, 'KZT', 1, 15000, 'transfer', 'completed', '2023-04-10', '2023-04-10', 'Dame to Tatum');



-- INSERT INTO exchange_rates (rate_id, from_currency, to_currency, rate, valid_from, valid_to) VALUES
-- (1, 'USD', 'KZT', 450, '2023-01-01', '2023-12-31'),
-- (2, 'EUR', 'KZT', 500, '2023-01-01', '2023-12-31'),
-- (3, 'RUB', 'KZT', 6, '2023-01-01', '2023-12-31'),
-- (4, 'KZT', 'USD', 0.0022, '2023-01-01', '2023-12-31'),
-- (5, 'KZT', 'EUR', 0.0020, '2023-01-01', '2023-12-31'),
-- (6, 'KZT', 'RUB', 0.17, '2023-01-01', '2023-12-31'),
-- (7, 'USD', 'EUR', 0.92, '2023-01-01', '2023-12-31'),
-- (8, 'EUR', 'USD', 1.08, '2023-01-01', '2023-12-31'),
-- (9, 'USD', 'RUB', 83, '2023-01-01', '2023-12-31'),
-- (10,'EUR', 'RUB', 90, '2023-01-01', '2023-12-31');



-- INSERT INTO audit_log (log_id, table_name, record_id, action, old_values, new_values, changed_by, changed_at, ip_address) VALUES
-- (1, 'customers', 3, 'UPDATE', '{"status":"active"}', '{"status":"blocked"}', 'admin', '2023-03-01', '10.0.0.1'),
-- (2, 'accounts', 5, 'UPDATE', '{"is_active":true}', '{"is_active":false}', 'system', '2023-02-15', '10.0.0.2'),
-- (3, 'transactions', 8, 'UPDATE', '{"status":"pending"}', '{"status":"failed"}', 'system', '2023-04-08', '10.0.0.3'),
-- (4, 'customers', 7, 'UPDATE', '{"status":"active"}', '{"status":"frozen"}', 'admin', '2023-03-20', '10.0.0.4'),
-- (5, 'accounts', 1, 'UPDATE', '{"balance":400000}', '{"balance":500000}', 'system', '2023-04-03', '10.0.0.5'),
-- (6, 'transactions', 1, 'INSERT', NULL, '{"amount":50000}', 'system', '2023-04-01', '10.0.0.6'),
-- (7, 'exchange_rates', 1, 'UPDATE', '{"rate":445}', '{"rate":450}', 'fx_admin', '2023-02-01', '10.0.0.7'),
-- (8, 'accounts', 14, 'UPDATE', '{"is_active":true}', '{"is_active":false}', 'system', '2023-03-22', '10.0.0.8'),
-- (9, 'customers', 2, 'UPDATE', '{"daily_limit_kzt":120000}', '{"daily_limit_kzt":150000}', 'admin', '2023-01-20', '10.0.0.9'),
-- (10,'transactions', 10, 'INSERT', NULL, '{"amount":15000}', 'system', '2023-04-10', '10.0.0.10');

-- CREATE OR REPLACE FUNCTION process_transfer(
--     p_from_account_number VARCHAR,
--     p_to_account_number   VARCHAR,
--     p_amount              NUMERIC,
--     p_currency            VARCHAR,
--     p_description         TEXT
-- )
-- RETURNS TABLE(result_code INT, result_message TEXT)
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_from_account accounts%ROWTYPE;
--     v_to_account   accounts%ROWTYPE;
--     v_from_customer customers%ROWTYPE;
--     v_exchange_rate NUMERIC := 1;
--     v_amount_kzt NUMERIC;
--     v_today_total NUMERIC;
--     v_savepoint_name TEXT := 'sp_transfer';
-- BEGIN
    
--     SELECT * INTO v_from_account
--     FROM accounts
--     WHERE account_number = p_from_account_number
--     FOR UPDATE;

--     IF NOT FOUND THEN
--         RETURN QUERY SELECT 1001, 'Source account does not exist';
--         RETURN;
--     END IF;

--     SELECT * INTO v_to_account
--     FROM accounts
--     WHERE account_number = p_to_account_number
--     FOR UPDATE;

--     IF NOT FOUND THEN
--         RETURN QUERY SELECT 1002, 'Destination account does not exist';
--         RETURN;
--     END IF;

    
--     IF NOT v_from_account.is_active THEN
--         RETURN QUERY SELECT 1003, 'Source account is inactive';
--         RETURN;
--     END IF;

--     IF NOT v_to_account.is_active THEN
--         RETURN QUERY SELECT 1004, 'Destination account is inactive';
--         RETURN;
--     END IF;

    
--     SELECT * INTO v_from_customer
--     FROM customers
--     WHERE customer_id = v_from_account.customer_id;

--     IF v_from_customer.status <> 'active' THEN
--         RETURN QUERY SELECT 1005, 'Customer is not active';
--         RETURN;
--     END IF;

   
--     IF v_from_account.balance < p_amount THEN
--         RETURN QUERY SELECT 1006, 'Insufficient balance';
--         RETURN;
--     END IF;

    
--     SELECT COALESCE(SUM(amount_kzt),0) INTO v_today_total
--     FROM transactions t
--     JOIN accounts a ON t.from_account_id = a.account_id
--     WHERE a.customer_id = v_from_customer.customer_id
--       AND t.status = 'completed'
--       AND t.created_at::date = CURRENT_DATE;

    
--     IF p_currency <> 'KZT' THEN
--         SELECT rate INTO v_exchange_rate
--         FROM exchange_rates
--         WHERE from_currency = p_currency
--           AND to_currency = 'KZT'
--           AND valid_from <= NOW()
--           AND (valid_to IS NULL OR valid_to >= NOW())
--         ORDER BY valid_from DESC
--         LIMIT 1;

--         IF NOT FOUND THEN
--             RETURN QUERY SELECT 1007, 'Exchange rate not found for ' || p_currency || ' to KZT';
--             RETURN;
--         END IF;

--         v_amount_kzt := p_amount * v_exchange_rate;
--     ELSE
--         v_amount_kzt := p_amount;
--     END IF;

--     IF v_today_total + v_amount_kzt > v_from_customer.daily_limit_kzt THEN
--         RETURN QUERY SELECT 1008, 'Daily transaction limit exceeded';
--         RETURN;
--     END IF;

    
--     SAVEPOINT sp_transfer;

--     BEGIN
        
--         UPDATE accounts
--         SET balance = balance - p_amount
--         WHERE account_id = v_from_account.account_id;

--         UPDATE accounts
--         SET balance = balance + CASE 
--                                     WHEN currency = p_currency THEN p_amount
--                                     ELSE p_amount * v_exchange_rate
--                                 END
--         WHERE account_id = v_to_account.account_id;

        
--         INSERT INTO transactions(
--             from_account_id,
--             to_account_id,
--             amount,
--             currency,
--             exchange_rate,
--             amount_kzt,
--             type,
--             status,
--             created_at,
--             completed_at,
--             description
--         ) VALUES (
--             v_from_account.account_id,
--             v_to_account.account_id,
--             p_amount,
--             p_currency,
--             v_exchange_rate,
--             v_amount_kzt,
--             'transfer',
--             'completed',
--             NOW(),
--             NOW(),
--             p_description
--         );

        
--         INSERT INTO audit_log(table_name, record_id, action, old_values, new_values, changed_by, changed_at, ip_address)
--         VALUES
--         ('accounts', v_from_account.account_id, 'UPDATE', 
--          jsonb_build_object('balance', v_from_account.balance),
--          jsonb_build_object('balance', v_from_account.balance - p_amount),
--          'system', NOW(), inet_client_addr());

--         INSERT INTO audit_log(table_name, record_id, action, old_values, new_values, changed_by, changed_at, ip_address)
--         VALUES
--         ('accounts', v_to_account.account_id, 'UPDATE', 
--          jsonb_build_object('balance', v_to_account.balance),
--          jsonb_build_object('balance', v_to_account.balance + CASE 
--                                     WHEN currency = p_currency THEN p_amount
--                                     ELSE p_amount * v_exchange_rate
--                                 END),
--          'system', NOW(), inet_client_addr());

--         RETURN QUERY SELECT 0, 'Transfer completed successfully';



        
--         INSERT INTO transactions(
--             from_account_id,
--             to_account_id,
--             amount,
--             currency,
--             exchange_rate,
--             amount_kzt,
--             type,
--             status,
--             created_at,
--             description
--         ) VALUES (
--             v_from_account.account_id,
--             v_to_account.account_id,
--             p_amount,
--             p_currency,
--             v_exchange_rate,
--             v_amount_kzt,
--             'transfer',
--             'failed',
--             NOW(),
--             p_description
--         );

--         RETURN QUERY SELECT 2000, 'Transfer failed: ' || SQLERRM;
--     END;

-- END;
-- $$;


-- SELECT * FROM process_transfer(
--     'ACC1001',        -- from account
--     'ACC2001',        -- to account
--     5000,             -- amount
--     'KZT',            -- currency
--     'Payment for services'
-- );


-- SELECT * FROM process_transfer(
--     'NON_EXIST',
--     'ACC2001',
--     1000,
--     'KZT',
--     'Test missing from account'
-- );

-- SELECT * FROM process_transfer(
--     'ACC_INACTIVE',
--     'ACC2001',
--     500,
--     'KZT',
--     'Inactive account test'
-- );


-- CREATE OR REPLACE VIEW customer_balance_summary AS
-- WITH account_balances_kzt AS (
--     SELECT 
--         a.account_id,
--         a.customer_id,
--         a.account_number,
--         a.currency,
--         a.balance,
--         COALESCE(
--             CASE 
--                 WHEN a.currency = 'KZT' THEN a.balance
--                 ELSE a.balance * er.rate
--             END, a.balance
--         ) AS balance_kzt
--     FROM accounts a
--     LEFT JOIN LATERAL (
--         SELECT rate
--         FROM exchange_rates
--         WHERE from_currency = a.currency
--           AND to_currency = 'KZT'
--           AND valid_from <= NOW()
--           AND (valid_to IS NULL OR valid_to >= NOW())
--         ORDER BY valid_from DESC
--         LIMIT 1
--     ) er ON TRUE
-- ),

-- per_customer_summary AS (
--     SELECT
--         c.customer_id,
--         c.full_name,
--         c.status,
--         c.daily_limit_kzt,
--         a.account_id,
--         a.account_number,
--         a.currency,
--         a.balance,
--         a.balance_kzt,
--         SUM(a.balance_kzt) OVER (PARTITION BY c.customer_id) AS total_balance_kzt
--     FROM customers c
--     JOIN account_balances_kzt a ON c.customer_id = a.customer_id
-- ),

-- ranked AS (
--     SELECT 
--         *,
--         ROUND(
--             100.0 * total_balance_kzt / NULLIF(daily_limit_kzt, 0), 
--             2
--         ) AS daily_limit_util_pct
--     FROM per_customer_summary
-- )

-- SELECT
--     *,
--     RANK() OVER (ORDER BY total_balance_kzt DESC) AS rank_by_balance
-- FROM ranked
-- ORDER BY rank_by_balance, customer_id, account_id;



-- SELECT *
-- FROM customer_balance_summary
-- ORDER BY customer_id;


-- CREATE OR REPLACE VIEW daily_transaction_report AS
-- WITH txn_agg AS (
--     SELECT 
--         DATE(created_at) AS txn_date,
--         type,
--         SUM(amount_kzt) AS total_volume_kzt,
--         COUNT(*) AS txn_count,
--         AVG(amount_kzt) AS avg_amount_kzt
--     FROM transactions
--     WHERE status = 'completed'
--     GROUP BY DATE(created_at), type
-- ),
-- txn_with_running AS (
--     SELECT 
--         txn_date,
--         type,
--         total_volume_kzt,
--         txn_count,
--         avg_amount_kzt,
--         SUM(total_volume_kzt) OVER (PARTITION BY type ORDER BY txn_date) AS running_total_volume,
--         SUM(txn_count) OVER (PARTITION BY type ORDER BY txn_date) AS running_txn_count,
--         LAG(total_volume_kzt) OVER (PARTITION BY type ORDER BY txn_date) AS prev_day_volume
--     FROM txn_agg
-- )
-- SELECT 
--     txn_date,
--     type,
--     total_volume_kzt,
--     txn_count,
--     avg_amount_kzt,
--     running_total_volume,
--     running_txn_count,
--     ROUND(100.0 * (total_volume_kzt - COALESCE(prev_day_volume,0)) / NULLIF(COALESCE(prev_day_volume,0),1),2) AS day_over_day_growth_pct
-- FROM txn_with_running
-- ORDER BY txn_date, type;

-- SELECT * FROM daily_transaction_report;


-- CREATE OR REPLACE VIEW suspicious_activity_view
-- WITH (security_barrier) AS
-- WITH txn_kzt AS (
--     SELECT 
--         t.transaction_id,
--         t.from_account_id,
--         t.to_account_id,
--         t.amount,
--         t.currency,
--         t.amount_kzt,
--         t.created_at,
--         a.customer_id AS sender_customer_id
--     FROM transactions t
--     JOIN accounts a ON t.from_account_id = a.account_id
-- ),
-- txn_hourly AS (
--     SELECT 
--         sender_customer_id,
--         DATE_TRUNC('hour', created_at) AS hour_start,
--         COUNT(*) AS txn_count
--     FROM txn_kzt
--     GROUP BY sender_customer_id, DATE_TRUNC('hour', created_at)
--     HAVING COUNT(*) > 10
-- ),
-- rapid_seq AS (
--     SELECT 
--         sender_customer_id,
--         transaction_id,
--         created_at,
--         LEAD(created_at) OVER (PARTITION BY sender_customer_id ORDER BY created_at) AS next_txn,
--         CASE 
--             WHEN LEAD(created_at) OVER (PARTITION BY sender_customer_id ORDER BY created_at) - created_at < INTERVAL '1 minute' THEN TRUE
--             ELSE FALSE
--         END AS rapid
--     FROM txn_kzt
-- )
-- SELECT 
--     t.transaction_id,
--     t.from_account_id,
--     t.to_account_id,
--     t.amount,
--     t.currency,
--     t.amount_kzt,
--     t.created_at,
--     CASE WHEN t.amount_kzt > 5000000 THEN TRUE ELSE FALSE END AS over_5M_kzt,
--     CASE WHEN h.txn_count IS NOT NULL THEN TRUE ELSE FALSE END AS high_freq_hour,
--     CASE WHEN r.rapid THEN TRUE ELSE FALSE END AS rapid_seq_transfer
-- FROM txn_kzt t
-- LEFT JOIN txn_hourly h ON t.sender_customer_id = h.sender_customer_id
-- LEFT JOIN rapid_seq r ON t.transaction_id = r.transaction_id
-- WHERE t.amount_kzt > 5000000 OR h.txn_count IS NOT NULL OR r.rapid = TRUE;


-- select * from suspicious_activity_view;


-- CREATE INDEX idx_accounts_account_number
-- ON accounts(account_number);

-- CREATE INDEX idx_transactions_created_at
-- ON transactions(created_at);

-- EXPLAIN ANALYZE
-- SELECT * FROM accounts WHERE account_number='KZ123BANK000000000001';

-- 2
-- CREATE INDEX idx_customers_iin_hash
-- ON customers USING HASH(iin);

-- EXPLAIN ANALYZE
-- SELECT * FROM customers WHERE iin='123456789012';


-- 3
-- CREATE INDEX idx_audit_log_old_values_gin
-- ON audit_log USING GIN(old_values);

-- CREATE INDEX idx_audit_log_new_values_gin
-- ON audit_log USING GIN(new_values);
-- explain
-- SELECT * FROM audit_log
-- WHERE old_values @> '{"balance": 500000}';


-- 4
-- CREATE INDEX idx_accounts_active_partial
-- ON accounts(balance)
-- WHERE is_active = true;

-- explain
-- SELECT * FROM accounts WHERE is_active = true AND balance > 100000;


-- 5
-- CREATE INDEX idx_transactions_sender_date
-- ON transactions(from_account_id, created_at DESC);


-- 6
-- CREATE INDEX idx_customers_email_ci
-- ON customers (LOWER(email));


-- 7
-- CREATE INDEX idx_accounts_covering_active
-- ON accounts(customer_id, balance, currency)
-- WHERE is_active = true;

-- Explain analyse
-- select * from accounts where is_active = true;


-- CREATE OR REPLACE FUNCTION process_salary_batch(
--     p_company_account_number VARCHAR,
--     p_payments JSONB  
-- )
-- RETURNS TABLE (
--     successful_count INT,
--     failed_count INT,
--     failed_details JSONB
-- )
-- LANGUAGE plpgsql
-- AS $$
-- DECLARE
--     v_company_account accounts%ROWTYPE;
--     v_total_batch NUMERIC := 0;
--     v_payment JSONB;
--     v_iin VARCHAR;
--     v_amount NUMERIC;
--     v_description TEXT;
--     v_customer customers%ROWTYPE;
--     v_accounts_to_update JSONB := '[]'::JSONB;
--     v_failed JSONB := '[]'::JSONB;
--     v_successful INT := 0;
--     v_failed_count INT := 0;
--     v_savepoint_name TEXT;
--     v_lock_key BIGINT;
-- BEGIN
   
--     SELECT ('x' || md5(p_company_account_number))::bit(64)::bigint INTO v_lock_key;
--     PERFORM pg_advisory_xact_lock(v_lock_key);

   
--     SELECT * INTO v_company_account
--     FROM accounts
--     WHERE account_number = p_company_account_number
--     FOR UPDATE;

--     IF NOT FOUND THEN
--         RAISE EXCEPTION 'Company account not found: %', p_company_account_number;
--     END IF;

--     IF NOT v_company_account.is_active THEN
--         RAISE EXCEPTION 'Company account is inactive';
--     END IF;

    
--     FOR v_payment IN SELECT * FROM jsonb_array_elements(p_payments)
--     LOOP
--         v_amount := (v_payment->>'amount')::NUMERIC;
--         v_total_batch := v_total_batch + v_amount;
--     END LOOP;

--     IF v_company_account.balance < v_total_batch THEN
--         RAISE EXCEPTION 'Insufficient balance in company account. Required: %, Available: %', v_total_batch, v_company_account.balance;
--     END IF;

    
--     FOR v_payment IN SELECT * FROM jsonb_array_elements(p_payments)
--     LOOP
--         v_savepoint_name := 'sp_' || (v_payment->>'iin');
--         SAVEPOINT sp_salary;

--         BEGIN
--     v_iin := v_payment->>'iin';
--     v_amount := (v_payment->>'amount')::NUMERIC;
--     v_description := v_payment->>'description';

--     SELECT * INTO v_customer
--     FROM customers
--     WHERE iin = v_iin;

--     IF NOT FOUND THEN
--         RAISE EXCEPTION 'Customer not found for IIN %', v_iin;
--     END IF;

--     PERFORM 1 FROM accounts
--     WHERE customer_id = v_customer.customer_id
--       AND is_active = TRUE;

--     IF NOT FOUND THEN
--         RAISE EXCEPTION 'No active account for customer IIN %', v_iin;
--     END IF;

--     v_accounts_to_update := v_accounts_to_update || jsonb_build_object(
--         'customer_id', v_customer.customer_id,
--         'amount', v_amount,
--         'description', v_description
--     );

--     v_successful := v_successful + 1;

-- EXCEPTION WHEN OTHERS THEN
--     v_failed := v_failed || jsonb_build_object(
--         'iin', v_iin,
--         'amount', v_amount,
--         'description', v_description,
--         'error', SQLERRM
--     );
--     v_failed_count := v_failed_count + 1;
-- END;

--     END LOOP;

    
--     UPDATE accounts
--     SET balance = balance - v_total_batch
--     WHERE account_id = v_company_account.account_id;

    
--     FOR v_payment IN SELECT * FROM jsonb_array_elements(v_accounts_to_update)
--     LOOP
--         UPDATE accounts
--         SET balance = balance + (v_payment->>'amount')::NUMERIC
--         WHERE customer_id = (v_payment->>'customer_id')::INT
--           AND is_active = TRUE;
--     END LOOP;

    
--     INSERT INTO audit_log(
--         table_name,
--         record_id,
--         action,
--         old_values,
--         new_values,
--         changed_by,
--         changed_at,
--         ip_address
--     ) VALUES (
--         'salary_batch',
--         NULL,
--         'INSERT',
--         NULL,
--         jsonb_build_object(
--             'company_account', p_company_account_number,
--             'total_batch', v_total_batch,
--             'successful_count', v_successful,
--             'failed_count', v_failed_count
--         ),
--         'system',
--         NOW(),
--         inet_client_addr()
--     );

    
--     RETURN QUERY SELECT v_successful, v_failed_count, v_failed;

-- END;
-- $$;


-- CREATE MATERIALIZED VIEW salary_batch_report AS
-- SELECT 
--     al.changed_at AS batch_date,
--     al.new_values->>'company_account' AS company_account,
--     (al.new_values->>'total_batch')::NUMERIC AS total_batch,
--     (al.new_values->>'successful_count')::INT AS successful_count,
--     (al.new_values->>'failed_count')::INT AS failed_count
-- FROM audit_log al
-- WHERE table_name = 'salary_batch'
-- ORDER BY changed_at DESC;

-- refresh materialized view salary_batch_report;
-- select * from salary_batch_report;





