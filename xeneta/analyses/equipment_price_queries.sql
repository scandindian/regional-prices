SELECT
    dp.equipment_id,
    dp.origin_pid,
    dp.destination_pid,
    o.slug AS origin_slug,
    d.slug AS destination_slug,
    AVG(c.value) AS avg_price_usd,
    MEDIAN(c.value) AS median_price_usd
FROM
    "dev"."main_staging"."staging_charges" c
    JOIN "dev"."main_staging"."staging_datapoints" dp USING (d_id)
    JOIN "dev"."main_raw"."de_case_study_ports" o ON dp.origin_pid = o.pid
    JOIN "dev"."main_raw"."de_case_study_ports" d ON dp.destination_pid = d.pid
WHERE
    dp.equipment_id = 2
    AND o.slug = 'china_east_main'
    AND d.slug = 'us_west_coast'
GROUP BY
    1, 2, 3, 4, 5;