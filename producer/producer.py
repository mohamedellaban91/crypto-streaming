import json
import time
import requests
from kafka import KafkaProducer
from datetime import datetime
import os

KAFKA_BOOTSTRAP_SERVERS = os.getenv("KAFKA_BOOTSTRAP_SERVERS", "localhost:9092")
TOPIC_NAME = "crypto_market"

producer = KafkaProducer(
    bootstrap_servers=KAFKA_BOOTSTRAP_SERVERS,
    value_serializer=lambda x: json.dumps(x).encode("utf-8"),
    retries=5
)

def fetch_crypto_data():
    url = "https://api.coingecko.com/api/v3/coins/markets"
    params = {
        "vs_currency": "usd",
        "order": "market_cap_desc",
        "per_page": 20,
        "page": 1,
        "sparkline": False,
        "price_change_percentage": "24h"
    }
    response = requests.get(url, params=params, timeout=10)
    return response.json()

def send_to_kafka(data):
    for coin in data:
        record = {
            "symbol": coin.get("symbol", "").upper(),
            "coin_name": coin.get("name", ""),
            "exchange": "CoinGecko",
            "current_price": coin.get("current_price"),
            "volume_24h": coin.get("total_volume"),
            "market_rank": coin.get("market_cap_rank"),
            "market_cap": coin.get("market_cap"),
            "price_change_24h": coin.get("price_change_percentage_24h"),
            "high_24h": coin.get("high_24h"),
            "low_24h": coin.get("low_24h"),
            "timestamp": datetime.utcnow().isoformat(),
            "currency": "USD"
        }
        producer.send(TOPIC_NAME, value=record)
        print(f"Sent: {record['symbol']} - ${record['current_price']}")
    producer.flush()

if __name__ == "__main__":
    print("Producer started...")
    while True:
        try:
            data = fetch_crypto_data()
            send_to_kafka(data)
            print(f"Batch sent at {datetime.utcnow().isoformat()}")
            time.sleep(60)
        except Exception as e:
            print(f"Error: {e}")
            time.sleep(10)