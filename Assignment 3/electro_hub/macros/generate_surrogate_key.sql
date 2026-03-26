{% macro generate_surrogate_key(field_list) %}
    md5(
        {% for field in field_list %}
            coalesce(cast({{ field }} as string), '_null_')
            {% if not loop.last %} || '-' || {% endif %}
        {% endfor %}
    )
{% endmacro %}

-- Ми використовуємо макрос, щоб забезпечити однакову логіку генерації ключів по всьому проекту. 
-- Це зменшує дублювання коду та спрощує підтримку (DRY — Don't Repeat Yourself).