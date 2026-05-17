INSERT INTO dim_currency (currency_code)
VALUES ('USD'), ('USDT'), ('EUR')
ON CONFLICT (currency_code) DO NOTHING;

INSERT INTO dim_exchange (exchange_name, country)
VALUES
('CoinGecko', 'Global'),
('Binance', 'UAE'),
('Coinbase', 'USA'),
('Kraken', 'USA')
ON CONFLICT (exchange_name) DO NOTHING;

INSERT INTO dim_coin (symbol, coin_name, category)
VALUES
('BTC', 'Bitcoin', 'Store of Value'),
('ETH', 'Ethereum', 'Smart Contracts'),
('SOL', 'Solana', 'Layer 1'),
('BNB', 'Binance Coin', 'Exchange Token'),
('ADA', 'Cardano', 'Layer 1'),
('DOGE', 'Dogecoin', 'Meme Coin'),
('XRP', 'Ripple', 'Payments'),
('AVAX', 'Avalanche', 'Layer 1'),
('LINK', 'Chainlink', 'Oracle'),
('TRX', 'TRON', 'Layer 1')
ON CONFLICT (symbol) DO NOTHING;

INSERT INTO dim_currency (currency_key, currency_code)
VALUES (-1, 'UNKNOWN')
ON CONFLICT DO NOTHING;

INSERT INTO dim_exchange (exchange_key, exchange_name, country)
VALUES (-1, 'UNKNOWN', 'Unknown')
ON CONFLICT DO NOTHING;

INSERT INTO dim_coin (coin_key, symbol, coin_name, category)
VALUES (-1, 'UNKNOWN', 'Unknown Coin', 'Unknown')
ON CONFLICT DO NOTHING;