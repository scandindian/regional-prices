CREATE SCHEMA IF NOT EXISTS raw;

-- Load ports
CREATE
OR REPLACE TABLE raw.ports AS
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_ports.csv',
        HEADER = TRUE
    );

-- Load regions
CREATE
OR REPLACE TABLE raw.regions AS
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_regions.csv',
        HEADER = TRUE
    );

-- Load charges (union)
CREATE
OR REPLACE TABLE raw.charges AS
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_charges_1.csv',
        HEADER = TRUE
    )
UNION ALL
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_charges_2.csv',
        HEADER = TRUE
    )
UNION ALL
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_charges_3.csv',
        HEADER = TRUE
    );

-- Load datapoints (union)
CREATE
OR REPLACE TABLE raw.datapoints AS
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_datapoints_1.csv',
        HEADER = TRUE
    )
UNION ALL
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_datapoints_2.csv',
        HEADER = TRUE
    )
UNION ALL
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_datapoints_3.csv',
        HEADER = TRUE
    );

-- Load exchange rates
CREATE
OR REPLACE TABLE raw.exchange_rates AS
SELECT
    *
FROM
    read_csv_auto (
        'input_files/DE_casestudy_exchange_rates.csv',
        HEADER = TRUE
    );