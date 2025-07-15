{{
  config(
    materialized = 'table',
    )
}}

SELECT
pid,
region
FROM {{ ref('de_case_study_regions') }}