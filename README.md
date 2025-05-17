# Data Analytics Assessment

This repository contains SQL queries for analyzing customer data and identifying business opportunities.

## Question 1: High-Value Customers with Multiple Products

### Approach
- Used Common Table Expression (CTE) to first aggregate customer plan data
- Grouped plans by customer and plan type to identify product diversity
- Filtered for customers with multiple product types
- Sorted by total value to prioritize highest-value customers

### Technical Details
- Joined users_customuser with plans_plan to get customer plan information
- Used amount > 0 to ensure only funded plans are considered
- Grouped results to show total value across all customer's plans
- Included email for easy customer contact

### Challenges
- Needed to ensure we only count funded plans (resolved by adding amount > 0 filter)
- Had to handle potential duplicate plans (resolved using COUNT(DISTINCT))
- Considered scalability for large datasets by using efficient joins and indexing

## Additional Notes
- All queries are optimized for performance with appropriate indexing
- Comments are included for complex logic sections
- Formatting follows standard SQL best practices

## Question 2: Transaction Frequency Analysis

### Approach
- Used a CTE to count transactions per customer per month
- Calculated each customer’s average monthly transaction count
- Categorized customers as High, Medium, or Low Frequency based on thresholds
- Joined with users_customuser to provide customer details

### Challenges
- Ensured correct grouping by both customer and month
- Used AVG to handle customers with varying activity across months
- Considered edge cases where customers may have months with zero transactions (these months are not counted in the average)

## Question 3: Account Inactivity Alert

### Approach
- Created a CTE to find the most recent transaction date for each plan
- Used COALESCE to handle cases where there might be no transactions (falling back to plan creation date)
- Calculated inactivity period using DATEDIFF
- Only considered active plans to avoid false positives from closed accounts
- Included customer contact information for follow-up actions

### Technical Details
- Used LEFT JOIN to include plans that might have no transactions
- Filtered for plans with no activity in the last 365 days
- Included plan amount to help prioritize high-value inactive accounts
- Sorted by inactivity duration to highlight most critical cases first

### Challenges
- Needed to handle edge cases where plans had no transactions yet
- Ensured we only flagged genuinely inactive accounts (not closed/terminated)
- Considered both savings and investment plans in the analysis

## Question 4: Customer Lifetime Value (CLV) Estimation

### Approach
- Calculated account tenure in months since signup (date_joined)
- Aggregated total transactions and transaction value per customer
- Estimated average profit per transaction as 0.1% of transaction value
- Used the provided CLV formula: (total_transactions / tenure) * 12 * avg_profit_per_transaction
- Ordered results by estimated CLV (highest to lowest)

### Challenges
- Handled division by zero for new customers (tenure = 0)
- Used COALESCE to ensure customers with no transactions are included
- Provided customer contact details for marketing follow-up
