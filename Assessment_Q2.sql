-- Question 2: Transaction Frequency Analysis
-- Purpose: Segment customers by their average monthly transaction frequency
-- Approach: Count transactions per customer per month, calculate average, and categorize

WITH MonthlyTransactions AS (
    SELECT
        s.owner_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS year_month,
        COUNT(*) AS monthly_txn_count
    FROM savings_savingsaccount s
    GROUP BY s.owner_id, year_month
),
AvgMonthlyFrequency AS (
    SELECT
        m.owner_id,
        AVG(m.monthly_txn_count) AS avg_txn_per_month
    FROM MonthlyTransactions m
    GROUP BY m.owner_id
)
SELECT
    u.id AS user_id,
    u.name AS customer_name,
    u.email,
    ROUND(a.avg_txn_per_month, 2) AS avg_txn_per_month,
    CASE
        WHEN a.avg_txn_per_month >= 10 THEN 'High Frequency'
        WHEN a.avg_txn_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category
FROM AvgMonthlyFrequency a
JOIN users_customuser u ON a.owner_id = u.id
ORDER BY avg_txn_per_month DESC;
