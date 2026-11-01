select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.purchase_date,
    o.delivery_date,
    o.estimated_delivery_date,
    p.credit_card_amt,
    p.boleto_amt,
    p.voucher_amt,
    p.debit_card_amt,
    p.credit_card_amt + p.boleto_amt + p.voucher_amt + p.debit_card_amt as total_payment_amount
from {{ ref("stg_orders") }} as o
join {{ ref("int_payment_methods_pivoted") }} as p on o.order_id = p.order_id