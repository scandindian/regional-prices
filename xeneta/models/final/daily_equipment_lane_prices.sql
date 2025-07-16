-- models/final/daily_equipment_lane_prices.sql

-- depends_on: {{ ref('staging_datapoints') }}
-- depends_on: {{ ref('staging_charges') }}
-- depends_on: {{ ref('staging_exchange_rates') }}

{{
  config(
    materialized = 'table',
    schema = 'final'
  )
}}

WITH expanded_days AS (
  SELECT
    d.d_id,
    d.origin_pid,
    d.destination_pid,
    d.equipment_id,
    gs.day
  FROM {{ ref('staging_datapoints') }} d
  CROSS JOIN LATERAL generate_series(d.valid_from, d.valid_to, INTERVAL 1 DAY) AS gs(day)
),

charges_usd AS (
  SELECT
    ed.day,
    ed.origin_pid,
    ed.destination_pid,
    ed.equipment_id,
    ROUND(c.value / er.rate, 2) AS price_usd
  FROM expanded_days ed
  JOIN {{ ref('staging_charges') }} c ON ed.d_id = c.d_id
  JOIN {{ ref('staging_exchange_rates') }} er 
    ON er.day = ed.day AND er.currency = c.currency
),

daily_lane_prices AS (
  SELECT
    day,
    origin_pid,
    destination_pid,
    equipment_id,
    SUM(price_usd) AS total_daily_price_usd
  FROM charges_usd
  GROUP BY 1,2,3,4
)

SELECT
  origin_pid,
  destination_pid,
  equipment_id,
  ROUND(AVG(total_daily_price_usd), 2) AS avg_price_usd,
  ROUND(MEDIAN(total_daily_price_usd), 2) AS median_price_usd
FROM daily_lane_prices
GROUP BY 1,2,3