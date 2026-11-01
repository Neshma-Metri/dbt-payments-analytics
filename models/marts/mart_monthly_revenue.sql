-- "What's our monthly revenue by payment method?"

select 
    DATE_TRUNC(purchase_date, MONTH) as months,
    sum(credit_card_amt) as credit_card_rev,
    sum(boleto_amt) as boleto_rev,
    sum(voucher_amt) as voucher_rev,
    sum(debit_card_amt) as debit_card_rev
from {{ ref('fct_orders') }}
group by DATE_TRUNC(purchase_date, MONTH)