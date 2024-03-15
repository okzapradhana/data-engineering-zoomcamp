WITH fhv AS (
    SELECT 
        *,
        'Fhv' AS service_type 
    FROM {{ ref('stg_fhv_tripdata') }}
),
dim_zones AS (
    SELECT 
        *
    FROM {{ ref('dim_zones') }}
    WHERE borough != 'Unknown'
)
SELECT
    fhv.dispatching_base_num,
    fhv.pickup_datetime,
    fhv.dropoff_datetime,
    fhv.pu_location_id,
    fhv.do_location_id,
    fhv.sr_flag,
    fhv.affiliated_base_number,
    fhv.service_type,
    pickup_zone.borough AS pickup_borough,
    pickup_zone.zone AS pickup_zone,
    -- pickup_zone.service_zone
    dropoff_zone.borough AS dropoff_borough,
    dropoff_zone.zone AS dropoff_zone,
    -- dropoff_zone.service_zone
FROM fhv
INNER JOIN dim_zones pickup_zone ON fhv.pu_location_id = pickup_zone.locationid
INNER JOIN dim_zones dropoff_zone ON fhv.do_location_id = dropoff_zone.locationid 