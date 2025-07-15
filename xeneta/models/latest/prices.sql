{{
  config(
    materialized = 'incremental',
    )
}}

SELECT 
er.day,
sd.d_id,
sd.origin_pid,
sd.destination_pid,
sd.company_id,
sd.equipment_id,
CASE WHEN sd.contract_length > 30 THEN 'long' ELSE 'short' END as contract_length_label,
ROUND(SUM(sc.value / er.rate)) as price
FROM {{ ref('staging_datapoints') }} sd
JOIN {{ ref('staging_charges') }} sc USING (d_id)
JOIN {{ ref('staging_exchange_rates') }} er ON day BETWEEN sd.valid_from AND sd.valid_to AND sc.currency = er.currency
GROUP BY 1,2,3,4,5,6,7