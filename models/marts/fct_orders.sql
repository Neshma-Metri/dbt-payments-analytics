{{ config(
    materialized='incremental',
    unique_key='order_id',
    partition_by={
      "field": "purchase_date",
      "data_type": "timestamp",
      "granularity": "month"
    }
) }}

  with orders as (
      select * from {{ ref('int_order_payments_joined') }}
  ),
  final as (
      select
          order_id,
          customer_id,
          order_status,
          purchase_date,
          delivery_date,
          estimated_delivery_date,
          total_payment_amount,
          credit_card_amt,
          boleto_amt,
          voucher_amt,
          debit_card_amt,
          not_defined_amt,
          -- delivery metrics
          timestamp_diff(delivery_date, purchase_date, day) as days_to_deliver,
          timestamp_diff(estimated_delivery_date, delivery_date, day) as days_delivery_delta
      from orders
  )
  select * from final
  {% if is_incremental() %}
    where purchase_date > (select max(purchase_date) from {{ this }})
  {% endif %}