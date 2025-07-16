-- depends_on: {{ ref('de_case_study_datapoints_1') }}
-- depends_on: {{ ref('de_case_study_datapoints_2') }}

{{
  config(
    materialized = 'incremental',
  )
}}

{% if not is_incremental() %}
SELECT 
  created::timestamp AS created,
  d_id,
  origin_pid,
  destination_pid,
  valid_from::date AS valid_from,
  valid_to::date AS valid_to,
  company_id,
  equipment_id,
  DATE_DIFF('day', valid_from::date, valid_to::date) AS contract_length
FROM {{ ref('de_case_study_datapoints_1') }}
{% else %}
SELECT 
  created::timestamp AS created,
  d_id,
  origin_pid,
  destination_pid,
  valid_from::date AS valid_from,
  valid_to::date AS valid_to,
  company_id,
  equipment_id,
  DATE_DIFF('day', valid_from::date, valid_to::date) AS contract_length
FROM {{ ref('de_case_study_datapoints_2') }}
{% endif %}
