  {% macro cents_to_reais(column_name) %}
      round(cast({{ column_name }} as numeric) / 100, 2)
  {% endmacro %}