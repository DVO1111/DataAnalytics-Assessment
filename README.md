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
