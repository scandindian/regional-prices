{{
  config(
    materialized = 'incremental',
    )
}}

{% if not is_incremental() %}
SELECT 
created::timestamp as created,
d_id,
origin_pid,
destination_pid,
valid_from::date as valid_from,
valid_to::date as valid_to,
company_id,
equipment_id,
contract_length
FROM {{ ref('de_case_study_datapoints_1') }}
{% else %}
SELECT 
created::timestamp as created,
d_id,
origin_pid,
destination_pid,
valid_from::date,
valid_to::date,
company_id,
equipment_id,
contract_length
FROM {{ ref('de_case_study_datapoints_2') }}
{% endif %}