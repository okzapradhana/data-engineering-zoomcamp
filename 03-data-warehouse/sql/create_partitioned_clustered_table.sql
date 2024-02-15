CREATE TABLE IF NOT EXISTS
  `de-laboratory.zoomcamp_dataset.green_taxi_clp` ( 
    VendorID INT64,
    lpep_pickup_datetime DATE,
    lpep_dropoff_datetime DATE,
    store_and_fwd_flag STRING,
    RatecodeID FLOAT64,
    PULocationID INT64,
    DOLocationID INT64,
    passenger_count FLOAT64,
    trip_distance FLOAT64,
    fare_amount FLOAT64,
    extra FLOAT64,
    mta_tax FLOAT64,
    tip_amount FLOAT64,
    tolls_amount FLOAT64,
    ehail_fee INT64,
    improvement_surcharge FLOAT64,
    total_amount FLOAT64,
    payment_type FLOAT64,
    trip_type FLOAT64,
    congestion_surcharge FLOAT64 
  )
PARTITION BY
  lpep_pickup_datetime
CLUSTER BY
  PULocationID AS
SELECT
  VendorID
  ,DATE(TIMESTAMP_MILLIS(lpep_pickup_datetime)) AS lpep_pickup_datetime
  ,DATE(TIMESTAMP_MILLIS(lpep_dropoff_datetime)) AS lpep_dropoff_datetime
  ,store_and_fwd_flag
  ,RatecodeID
  ,PULocationID
  ,DOLocationID
  ,passenger_count
  ,trip_distance
  ,fare_amount
  ,extra
  ,mta_tax
  ,tip_amount
  ,tolls_amount
  ,ehail_fee
  ,improvement_surcharge
  ,total_amount
  ,payment_type
  ,trip_type
  ,congestion_surcharge
FROM
  zoomcamp_dataset.ext_green_taxi