{% macro get_row_number_by(fields) %} ROW_NUMBER() OVER (ORDER BY {{ fields | join(', ') }}){% endmacro %}
