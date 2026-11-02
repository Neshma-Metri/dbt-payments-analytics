{% macro classify_customer_tier(column) %}
CASE
    WHEN {{ column }} < 100    THEN 'Bronze'
    WHEN {{ column }} < 500    THEN 'Silver'
    WHEN {{ column }} >= 500   THEN 'Gold'
    ELSE 'Unknown'
END
{% endmacro %}