CREATE EXTERNAL TABLE IF NOT EXISTS zoomcamp_dataset.ext_green_taxi
OPTIONS (
  format='parquet',
  uris=['gs://okza_zoomcamp_data/green_taxi_2022/green_taxi_data.parquet']
)