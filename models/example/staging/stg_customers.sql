select
    customer_id as cust_order_id,
    customer_unique_id as cust_unique_id,
    customer_zip_code_prefix as cust_zip_pfx,
    customer_city            as cust_city,
    customer_state           as cust_state
from {{ source("raw", "customers") }}