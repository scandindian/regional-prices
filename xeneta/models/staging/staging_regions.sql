-- depends_on: {{ ref('de_case_study_regions') }}
-- depends_on: {{ ref('de_case_study_ports') }}

{{
  config(
    materialized = 'table',
  )
}}

SELECT
  ports.pid,
  regions.name AS region
FROM {{ ref('de_case_study_ports') }} AS ports
JOIN {{ ref('de_case_study_regions') }} AS regions
  ON ports.slug = regions.slug
