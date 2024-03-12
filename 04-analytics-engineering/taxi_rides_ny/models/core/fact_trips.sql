WITH green AS (
    SELECT 
        *,
        'Green' AS service_type
    FROM {{ ref('stg_green_tripdata') }}
),
yellow AS (
    SELECT
        *,
        'Yellow' AS service_type
    FROM {{ ref('stg_yellow_tripdata') }}
),
union_trips AS (
    SELECT 
        *
    FROM green
    UNION ALL
    SELECT
        *
    FROM yellow
),
dim_zones AS (
    SELECT 
        *
    FROM {{ ref('dim_zones') }}
    WHERE borough != 'Unknown'
)
SELECT 
    union_trips.tripid, 
    union_trips.vendorid, 
    union_trips.service_type,
    union_trips.ratecodeid, 
    union_trips.pickup_locationid, 
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    union_trips.dropoff_locationid,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    union_trips.pickup_datetime, 
    union_trips.dropoff_datetime, 
    union_trips.store_and_fwd_flag, 
    union_trips.passenger_count, 
    union_trips.trip_distance, 
    union_trips.trip_type, 
    union_trips.fare_amount, 
    union_trips.extra, 
    union_trips.mta_tax, 
    union_trips.tip_amount, 
    union_trips.tolls_amount, 
    union_trips.ehail_fee, 
    union_trips.improvement_surcharge, 
    union_trips.total_amount, 
    union_trips.payment_type, 
    union_trips.payment_type_description
FROM union_trips
INNER JOIN dim_zones AS pickup_zone
ON union_trips.pickup_locationid = pickup_zone.locationid
INNER JOIN dim_zones AS dropoff_zone
ON union_trips.dropoff_locationid = dropoff_zone.locationid