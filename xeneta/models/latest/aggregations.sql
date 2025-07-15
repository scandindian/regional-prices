{{
  config(
    materialized = 'incremental',
    )
}}

{% if not is_incremental() %}
SELECT 
    day,
    origins.region as origin,
    destinations.region as destination,
    equipment_id,
    contract_length_label,
    ROUND(AVG(price)) as price
FROM {{ ref('prices') }}
JOIN {{ ref('staging_regions') }} origins ON prices.origin_pid = origins.pid
JOIN {{ ref('staging_regions') }} destinations ON prices.destination_pid = destinations.pid
GROUP BY 1,2,3,4,5
{% else %}
SELECT 
    day,
    origins.region as origin,
    destinations.region as destination,
    equipment_id,
    contract_length_label,
    ROUND(AVG(price)) as price
FROM {{ ref('prices') }}
JOIN {{ ref('staging_regions') }} origins ON prices.origin_pid = origins.pid
JOIN {{ ref('staging_regions') }} destinations ON prices.destination_pid = destinations.pid
GROUP BY 1,2,3,4,5
{% endif %}