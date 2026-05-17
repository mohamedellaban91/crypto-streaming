-- dim_coin
CREATE TABLE dim_coin (
    coin_key SERIAL PRIMARY KEY,
    symbol VARCHAR(20) UNIQUE NOT NULL,
    coin_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) DEFAULT 'Cryptocurrency'
);

-- dim_exchange
CREATE TABLE dim_exchange (
    exchange_key SERIAL PRIMARY KEY,
    exchange_name VARCHAR(100) UNIQUE NOT NULL,
    country VARCHAR(50) DEFAULT 'Global'
);

-- dim_currency
CREATE TABLE dim_currency (
    currency_key SERIAL PRIMARY KEY,
    currency_code VARCHAR(10) UNIQUE NOT NULL
);

-- dim_time
CREATE TABLE dim_time (
    time_key BIGINT PRIMARY KEY,
    full_date TIMESTAMP NOT NULL,
    hour INT,
    day INT,
    month INT,
    quarter INT,
    year INT,
    day_name VARCHAR(20),
    month_name VARCHAR(20),
    is_weekend BOOLEAN
);

-- fact_crypto_market_snapshot
CREATE TABLE fact_crypto_market_snapshot (
    snapshot_id SERIAL PRIMARY KEY,
    coin_key INT REFERENCES dim_coin(coin_key),
    exchange_key INT REFERENCES dim_exchange(exchange_key),
    time_key BIGINT REFERENCES dim_time(time_key),
    currency_key INT REFERENCES dim_currency(currency_key),
    price_usd NUMERIC(20,8),
    volume_24h NUMERIC(20,2),
    market_rank INT,
    market_cap NUMERIC(20,2),
    price_change_24h NUMERIC(10,4),
    high_24h NUMERIC(20,8),
    low_24h NUMERIC(20,8),
    ingestion_time TIMESTAMP DEFAULT NOW()
);