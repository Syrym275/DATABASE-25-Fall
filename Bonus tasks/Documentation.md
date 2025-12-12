1. process_transfer Function (Single Transfer Transaction)

Purpose:
Perform a secure, atomic transfer between two accounts, handling currency conversion and daily transaction limits.

Customer & Account validation:

Check existence of source/destination accounts and customer status.

Check account activity (is_active) to prevent invalid operations.

Currency conversion:

If the transfer currency differs from KZT, the function retrieves the latest exchange rate.

Uses COALESCE and fallback mechanisms to avoid null balances.

Daily limit enforcement:

Aggregates all completed transactions for the day and checks against customer limit to prevent overdrawing.

Subtransaction exception handling:

Uses BEGIN ... EXCEPTION ... END for individual operation safety.

Removed SAVEPOINT and ROLLBACK TO SAVEPOINT (PL/pgSQL does not allow them in functions).

Audit logging:

Every balance change is recorded with old/new values, timestamp, and client IP for compliance.

Result codes:

Returns structured integer codes and messages for easier API integration.



2. process_salary_batch Function (Batch Salary Payments)

Purpose:
Process multiple salary payments from a company account to employee accounts in one batch.
Batch validation:

Calculates v_total_batch first and checks company account balance.

Prevents partial batch execution if funds are insufficient.

Subtransaction for each payment:

Each payment is processed in an inner BEGIN ... EXCEPTION ... END block.

Ensures failures for one employee don’t stop the entire batch.

Employee & account validation:

Checks that the customer exists (SELECT * FROM customers)

Checks that the customer has at least one active account.

Balance updates:

Deducts total from company account after validating all payments.

Adds amounts to employees’ accounts in a loop, ensuring each employee gets paid individually.

Error tracking:

Failed payments are recorded in v_failed JSONB array with detailed error messages.

Returns successful_count, failed_count, and failed_details.

Audit logging:

Entire batch logged in audit_log with counts and total batch amount.

Avoided savepoints:

PL/pgSQL subtransaction blocks automatically rollback failed payments.

3. customer_balance_summary View

Purpose:
Provide a consolidated view of customer balances across all accounts in KZT, including limits, percentages, and ranking.

Design Decisions:

Use of CTEs to handle window functions:

Inner SUM computed per customer first (total_balance_kzt).

RANK applied in a separate step to avoid nested window functions (PostgreSQL does not allow them).

Currency conversion:

Accounts with non-KZT balances are converted using the latest valid exchange rate from exchange_rates.

LEFT JOIN LATERAL ensures that missing rates can be handled gracefully with COALESCE.

Limit utilization calculation:

daily_limit_util_pct computed as a percentage of total_balance_kzt over daily_limit_kzt.

Uses NULLIF to prevent division by zero.

Ranking customers by balance:

Uses RANK() OVER (ORDER BY total_balance_kzt DESC) to allow multiple customers with the same total balance to share rank.

Benefits:

Efficient query structure with window functions and CTEs.

Handles multi-currency accounts cleanly.

Provides all necessary fields for dashboards, reporting, and monitoring.


4. General Transactional Design Principles

Atomicity:
Each transaction (single transfer, salary batch) either fully succeeds or fails partially with safe rollback.

Isolation:

Row-level locks prevent concurrent balance modifications.

Advisory locks prevent concurrent batches for the same company.

Error handling:

Detailed error messages and logging for both single and batch operations.

Subtransactions ensure partial failures do not affect unrelated operations.

Auditability & Compliance:

Every update/insert is logged with timestamps, old/new values, and client IP.

Enables full traceability of transfers and batch payments.

Performance Considerations:

Batch updates reduce repeated locking overhead.

JSONB used to accumulate payment results efficiently.

Window functions optimized using CTEs for large customer datasets.
