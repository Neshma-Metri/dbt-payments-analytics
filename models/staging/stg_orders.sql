select
    order_id,
    customer_id,
    order_status,
    CAST(order_purchase_timestamp AS TIMESTAMP)      as purchase_date,
    CAST(order_approved_at AS TIMESTAMP)             as approve_date,
    CAST(order_delivered_carrier_date AS TIMESTAMP)  as carrier_date,
    CAST(order_delivered_customer_date AS TIMESTAMP) as delivery_date,
    CAST(order_estimated_delivery_date AS TIMESTAMP) as estimated_delivery_date
from {{ source("raw", "orders") }}