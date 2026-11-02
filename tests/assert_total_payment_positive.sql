  -- test 1: no orders should have negative total payments
  select order_id, total_payment_amount
  from {{ ref('fct_orders') }}
  where total_payment_amount < 0