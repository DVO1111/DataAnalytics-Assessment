-- Question 1: High-Value Customers with Multiple Products
-- Purpose: Identify customers who have both savings and investment plans for cross-selling opportunities
-- Approach: Use CTEs to first aggregate customer plan data, then filter for multiple product types

WITH CustomerPlans AS (
    -- First get all funded plans per customer and plan type
    SELECT 
        u.id as user_id,
        u.name as customer_name,
        u.email,
        p.plan_type_id,
        COUNT(DISTINCT p.id) as plans_count,
        SUM(p.amount) as total_deposits
    FROM users_customuser u
    JOIN plans_plan p ON u.id = p.owner_id
    WHERE p.amount > 0  -- Only consider funded plans
    GROUP BY u.id, u.name, u.email, p.plan_type_id
)
SELECT 
    cp1.customer_name,
    cp1.email,
    COUNT(DISTINCT cp1.plan_type_id) as product_types,
    SUM(cp1.total_deposits) as total_value
FROM CustomerPlans cp1
GROUP BY cp1.user_id, cp1.customer_name, cp1.email
HAVING COUNT(DISTINCT cp1.plan_type_id) >= 2  -- Must have at least 2 different plan types
ORDER BY total_value DESC;  -- Sort by highest value customers first
