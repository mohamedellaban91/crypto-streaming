# 🚀 Real-Time Crypto Data Engineering Pipeline

A real-time data engineering project that streams cryptocurrency market data using **Kafka**, processes it with **PySpark Structured Streaming**, and loads it into a **Star Schema Data Warehouse** on **Supabase (PostgreSQL)**.

---

## 🏗️ Architecture
CoinGecko API → Python Producer → Kafka → PySpark Structured Streaming → Supabase DW

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| Python | Data Producer |
| Apache Kafka | Message Broker |
| PySpark Structured Streaming | Stream Processing |
| Docker & Docker Compose | Containerization |
| Jupyter Notebook | Development Environment |
| Supabase (PostgreSQL) | Data Warehouse |

---

## 📊 Data Warehouse — Star Schema

### Fact Table
- `fact_crypto_market_snapshot` — Periodic Snapshot per coin per exchange per hour

### Dimension Tables
- `dim_coin` — Coin details (symbol, name, category)
- `dim_exchange` — Exchange details
- `dim_currency` — Currency codes
- `dim_time` — Time dimension with smart key (YYYYMMDDHH)

---

## 🔄 Pipeline Layers

| Layer | Description |
|-------|-------------|
| 🥉 Bronze | Raw JSON data from Kafka |
| 🥈 Silver | Cleaned & transformed data |
| 🥇 Gold | Star Schema loaded into Supabase |

---

## 🚀 How to Run

### 1. Clone the repo
```bash
git clone https://github.com/mohamedellaban91/crypto-streaming.git
cd crypto-streaming
```

### 2. Create .env file
SUPABASE_HOST=your-host
SUPABASE_PORT=5432
SUPABASE_DB=postgres
SUPABASE_USER=your-user
SUPABASE_PASSWORD=your-password
KAFKA_BOOTSTRAP_SERVERS=kafka:29092
TOPIC_NAME=crypto_market

### 3. Start Docker
```bash
sudo service docker start
docker compose up -d --build
```

### 4. Create Supabase Schema
Run SQL files in order from `/sql` folder on Supabase SQL Editor.

### 5. Open Jupyter
Go to `http://localhost:8888` and run `crypto_streaming.ipynb`

---

## 📁 Project Structure
crypto-streaming/
├── docker-compose.yml
├── producer/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── producer.py
├── notebooks/
│   └── crypto_streaming.ipynb
├── sql/
│   ├── 01_create_star_schema.sql
│   ├── 02_insert_dim_time.sql
│   └── 03_seed_dimensions.sql
└── .gitignore

---

## 👨‍💻 Author
Mohamed Ellaban
