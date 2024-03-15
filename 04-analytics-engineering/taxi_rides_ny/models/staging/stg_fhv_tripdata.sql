SELECT 
    dispatching_base_num,
    CAST(pickup_datetime AS timestamp) AS pickup_datetime,
    CAST(dropOff_datetime AS timestamp) AS dropoff_datetime,
    {{ dbt.safe_cast("pulocationid", api.Column.translate_type("integer")) }} AS pu_location_id,
    {{ dbt.safe_cast("dolocationid", api.Column.translate_type("integer")) }} AS do_location_id,
    {{ dbt.safe_cast("SR_Flag", api.Column.translate_type("integer")) }} AS sr_flag,
    Affiliated_base_number AS affiliated_base_number
FROM {{ source('staging', 'fhv_trips_2019') }}