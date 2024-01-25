# 01-Docker-Terraform

# Usage
1. Build the Image
```docker build -t nyc_taxi_ingest:1.0 .```

2. Ingest needed data
```
docker run --network zoomcamp_network nyc_taxi_ingest:1.0 --user=okza --password=zoomcamp-demo --db=zoomcamp-data --host=postgres --filepath=green_tripdata_2021-01.parquet --table=trips_green_taxi --url=https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2021-01.parquet

docker run --network zoomcamp_network nyc_taxi_ingest:1.0 --user=okza --password=zoomcamp-demo --db=zoomcamp-data --host=postgres --filepath=taxi_zone_lookup.csv --table=taxi_zone_lookup --url=https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv
```
