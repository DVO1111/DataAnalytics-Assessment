-- Question 4: Customer Lifetime Value (CLV) Estimation
-- Purpose: Estimate CLV using account tenure and transaction volume
-- Approach: Calculate tenure, total transactions, average profit per transaction, and estimate CLV

WITH TransactionStats AS (
    SELECT
        s.owner_id,
        COUNT(*) AS total_transactions,
        SUM(s.amount) AS total_transaction_value,
        AVG(s.amount) AS avg_transaction_value
    FROM savings_savingsaccount s
    GROUP BY s.owner_id
),
Tenure AS (
    SELECT
        u.id AS user_id,
        u.name AS customer_name,
        u.email,
        u.date_joined,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months
    FROM users_customuser u
)
SELECT
    t.user_id,
    t.customer_name,
    t.email,
    tenure_months,
    COALESCE(ts.total_transactions, 0) AS total_transactions,
    ROUND(COALESCE(ts.total_transaction_value, 0) * 0.001 / COALESCE(ts.total_transactions, 1), 2) AS avg_profit_per_transaction,
    -- CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction
    ROUND((COALESCE(ts.total_transactions, 0) / NULLIF(tenure_months, 0)) * 12 * (COALESCE(ts.total_transaction_value, 0) * 0.001 / COALESCE(ts.total_transactions, 1)), 2) AS estimated_clv
FROM Tenure t
LEFT JOIN TransactionStats ts ON t.user_id = ts.owner_id
ORDER BY estimated_clv DESC;
