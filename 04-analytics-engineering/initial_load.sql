-- RUN THIS ON BIGQUERY
CREATE TABLE IF NOT EXISTS `speedy-league-416712.zoomcamp_dataset.yellow_trips_20192020`
AS 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2019`
UNION ALL
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2020`
;

CREATE TABLE IF NOT EXISTS `speedy-league-416712.zoomcamp_dataset.green_trips_20192020`
AS 
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2019`
UNION ALL
SELECT * FROM `bigquery-public-data.new_york_taxi_trips.tlc_green_trips_2020`
;

ALTER TABLE `speedy-league-416712.zoomcamp_dataset.yellow_trips_20192020`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.yellow_trips_20192020`
  RENAME COLUMN pickup_datetime TO tpep_pickup_datetime;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.yellow_trips_20192020`
  RENAME COLUMN dropoff_datetime TO tpep_dropoff_datetime;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.yellow_trips_20192020`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.yellow_trips_20192020`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.yellow_trips_20192020`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.yellow_trips_20192020`
  RENAME COLUMN dropoff_location_id TO DOLocationID;

  -- Fixes green table schema
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.green_trips_20192020`
  RENAME COLUMN vendor_id TO VendorID;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.green_trips_20192020`
  RENAME COLUMN pickup_datetime TO lpep_pickup_datetime;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.green_trips_20192020`
  RENAME COLUMN dropoff_datetime TO lpep_dropoff_datetime;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.green_trips_20192020`
  RENAME COLUMN rate_code TO RatecodeID;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.green_trips_20192020`
  RENAME COLUMN imp_surcharge TO improvement_surcharge;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.green_trips_20192020`
  RENAME COLUMN pickup_location_id TO PULocationID;
ALTER TABLE `speedy-league-416712.zoomcamp_dataset.green_trips_20192020`
  RENAME COLUMN dropoff_location_id TO DOLocationID;