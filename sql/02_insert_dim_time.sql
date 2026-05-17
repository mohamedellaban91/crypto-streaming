INSERT INTO dim_time (time_key, full_date, hour, day, month, quarter, year, day_name, month_name, is_weekend)
SELECT
    TO_CHAR(gs, 'YYYYMMDDHH24')::BIGINT AS time_key,
    gs AS full_date,
    EXTRACT(HOUR FROM gs)::INT,
    EXTRACT(DAY FROM gs)::INT,
    EXTRACT(MONTH FROM gs)::INT,
    EXTRACT(QUARTER FROM gs)::INT,
    EXTRACT(YEAR FROM gs)::INT,
    TO_CHAR(gs, 'Day'),
    TO_CHAR(gs, 'Month'),
    EXTRACT(DOW FROM gs) IN (0, 6)
FROM generate_series(
    '2024-01-01 00:00:00'::timestamp,
    '2026-12-31 23:00:00'::timestamp,
    '1 hour'::interval
) AS gs;