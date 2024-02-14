LOAD DATA OVERWRITE de-laboratory.zoomcamp_dataset.green_taxi
FROM FILES (
  format='parquet',
  uris=['gs://okza_zoomcamp_data/green_taxi_2022/green_taxi_data.parquet']
)