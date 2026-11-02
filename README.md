# dbt Payments Analytics Pipeline
End-to-end analytics pipeline modelling Brazilian e-commerce payments data 
using dbt + BigQuery. Answers fintech-relevant business questions around 
revenue, customer lifetime value, and delivery performance.

## Business questions that can be answered:
- Which customers have the highest lifetime value?
- What is our monthly revenue by payment method?
- How does payment method affect delivery time?
- Which orders are at risk of late delivery?

## Architecture
Raw (BigQuery) → Staging (views) → Intermediate (ephemeral CTEs) → Marts (tables)

## Models
| Layer | Model | Description |
|---|---|---|
| Staging | stg_orders | Cleaned orders with type casted timestamps |
| Staging | stg_payments | Payment methods per order |
| Staging | stg_customers | Customer dimensions |
| Marts | fct_orders | One row per order, incremental and partitioned by month |
| Marts | dim_customers | Customer LTV and order history |
| Marts | mart_monthly_revenue | Revenue by payment method by month |

## Key Engineering Decisions
- **Incremental materialization** on fct_orders to avoid full table scans on every run
- **Monthly partitioning** on fct_orders to reduce BigQuery query costs at scale
- **Ephemeral intermediates**: zero storage cost for transformation CTEs
- **36 automated tests**: validating unique values, not_null values, accepted_values, relationships, composite keys
- **Source freshness monitoring** on raw.orders

## Testing
- 36 schema tests across all layers
- 1 singular test from assert_total_payment_positive
- Source freshness configured on raw.orders

## How to run this?
  ```bash
  dbt deps          # install packages
  dbt build         # run models + tests
  ```

## What I am planning to do next?
- Add clustering on fct_orders by customer_id for join performance
- Build 'mart_customer_cohorts' model for retention analysis
- Add Airflow DAG for scheduled runs
- Add row-level access policies for data governance
- Connect Looker for BI layer