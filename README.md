# data-engineering-zoomcamp
My works on Data Engineering Zoomcamp 2024

# Usage
Ingest needed data
1. ```
docker build -t nyc_taxi_ingest:1.0 .
```
2. ```
docker run --network zoomcamp_network nyc_taxi_ingest_new:1.0 --user=okza --password=zoomcamp-demo --db=zoomcamp-data --host=postgres --filepath=green_tripdata_2021-01.parquet --table=trips_green_taxi --url=https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2021-01.parquet

docker run --network zoomcamp_network nyc_taxi_ingest_new:1.0 --user=okza --password=zoomcamp-demo --db=zoomcamp-data --host=postgres --filepath=taxi_zone_lookup.csv --table=taxi_zone_lookup --url=https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv
```

# Improvements List
This contains list that can be improved
1. Add proper log using `logging` module