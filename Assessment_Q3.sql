-- Question 3: Account Inactivity Alert
-- Purpose: Identify accounts with no inflow transactions for over 1 year
-- Approach: Compare last transaction dates with current date to find inactive accounts

WITH LastTransactions AS (
    -- Get the most recent transaction for each plan
    SELECT 
        p.id as plan_id,
        p.owner_id,
        p.amount as plan_amount,
        p.status as plan_status,
        COALESCE(
            MAX(s.transaction_date),  -- Use latest transaction if exists
            p.created_date           -- Fallback to plan creation date
        ) as last_activity_date
    FROM plans_plan p
    LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id
    WHERE p.status = 'active'  -- Only consider active plans
    GROUP BY p.id, p.owner_id, p.amount, p.status, p.created_date
)
SELECT 
    u.id as user_id,
    u.name as customer_name,
    u.email,
    lt.plan_id,
    lt.plan_amount,
    lt.last_activity_date,
    DATEDIFF(CURRENT_DATE, lt.last_activity_date) as days_inactive
FROM LastTransactions lt
JOIN users_customuser u ON lt.owner_id = u.id
WHERE DATEDIFF(CURRENT_DATE, lt.last_activity_date) > 365  -- More than 1 year inactive
ORDER BY days_inactive DESC;  -- Show longest inactive accounts first
