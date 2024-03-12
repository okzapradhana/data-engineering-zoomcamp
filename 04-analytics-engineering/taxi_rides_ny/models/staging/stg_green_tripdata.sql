WITH tripdata AS (
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY vendorid, lpep_pickup_datetime) AS rn
    FROM {{ source('staging', 'green_trips_20192020') }}
    WHERE vendorid IS NOT NULL
)
SELECT
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['vendorid', 'lpep_pickup_datetime']) }} AS tripid,
    {{ dbt.safe_cast("vendorid", api.Column.translate_type("integer")) }} AS vendorid,
    {{ dbt.safe_cast("ratecodeid", api.Column.translate_type("integer")) }} AS ratecodeid,
    {{ dbt.safe_cast("pulocationid", api.Column.translate_type("integer")) }} AS pickup_locationid,
    {{ dbt.safe_cast("dolocationid", api.Column.translate_type("integer")) }} AS dropoff_locationid,
    
    -- timestamps
    CAST(lpep_pickup_datetime AS timestamp) AS pickup_datetime,
    CAST(lpep_dropoff_datetime AS timestamp) AS dropoff_datetime,
    
    -- trip info
    store_and_fwd_flag,
    {{ dbt.safe_cast("passenger_count", api.Column.translate_type("integer")) }} AS passenger_count,
    CAST(trip_distance AS numeric) AS trip_distance,
    {{ dbt.safe_cast("trip_type", api.Column.translate_type("integer")) }} AS trip_type,

    -- payment info
    CAST(fare_amount AS numeric) AS fare_amount,
    CAST(extra AS numeric) AS extra,
    CAST(mta_tax AS numeric) AS mta_tax,
    CAST(tip_amount AS numeric) AS tip_amount,
    CAST(tolls_amount AS numeric) AS tolls_amount,
    CAST(ehail_fee AS numeric) AS ehail_fee,
    CAST(improvement_surcharge AS numeric) AS improvement_surcharge,
    CAST(total_amount AS numeric) AS total_amount,
    coalesce({{ dbt.safe_cast("payment_type", api.Column.translate_type("integer")) }},0) AS payment_type,
    {{ get_payment_type_description("payment_type") }} AS payment_type_description
FROM tripdata
WHERE rn = 1


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  LIMIT 100

{% endif %}