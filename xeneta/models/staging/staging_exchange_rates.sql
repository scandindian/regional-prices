{{
  config(
    materialized = 'table',
    )
}}

SELECT
day,
currency,
rate
FROM {{ ref('de_case_study_exchange_rates') }}
