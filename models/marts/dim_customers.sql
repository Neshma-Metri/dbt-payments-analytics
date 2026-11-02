with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('fct_orders') }}
),
customer_orders as (
    select
        customer_id,
        min(purchase_date) as first_order_date,
        max(purchase_date) as most_recent_order_date,
        count(order_id) as total_orders,
        sum(total_payment_amount) as lifetime_value
    from orders
    group by 1
),
final as (
    select
        c.cust_order_id,
        c.cust_city,
        c.cust_state,
        co.first_order_date,
        co.most_recent_order_date,
        COALESCE(co.lifetime_value, 0) as lifetime_value,
        COALESCE(co.total_orders, 0)   as total_orders,
        {{ classify_customer_tier('co.lifetime_value') }} as customer_tier
    from customers c
    left join customer_orders co  on co.customer_id = c.cust_order_id
)
select * from final
