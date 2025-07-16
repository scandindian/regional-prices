-- depends_on: {{ ref('de_case_study_charges_1') }}
-- depends_on: {{ ref('de_case_study_charges_2') }}

{{
  config(
    materialized = 'incremental',
    )
}}

{% if not is_incremental() %}
SELECT 
d_id::INT as d_id,
currency::TEXT as currency,
charge_value::int as value
FROM {{ ref('de_case_study_charges_1') }}
{% else %}
SELECT 
d_id::INT as d_id,
currency::TEXT as currency,
charge_value::int as value
FROM {{ ref('de_case_study_charges_2') }}
{% endif %}