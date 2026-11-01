--credit_card, boleto, voucher, debit_card
select
    order_id,
    SUM(CASE WHEN payment_type = 'credit_card' THEN payment_value ELSE 0 END) as credit_card_amt,
    SUM(CASE WHEN payment_type = 'boleto' THEN payment_value ELSE 0 END) as boleto_amt,
    SUM(CASE WHEN payment_type = 'voucher' THEN payment_value ELSE 0 END) as voucher_amt,
    SUM(CASE WHEN payment_type = 'debit_card' THEN payment_value ELSE 0 END) as debit_card_amt
    SUM(CASE WHEN payment_type = 'not_defined' THEN payment_value ELSE 0 END) as not_defined_amt
from {{ ref("stg_payments") }}
group by order_id