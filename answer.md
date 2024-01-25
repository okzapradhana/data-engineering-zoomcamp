# Answers
```
1. docker run --help | grep "Automatically remove the container when it exits"

2. docker run -it --entrypoint /bin/bash python:3.9
then run pip list

3. SELECT COUNT(*)
FROM public.trips_green_taxi
WHERE lpep_pickup_datetime::TIMESTAMP::DATE = '2019-09-18' 
AND lpep_dropoff_datetime::TIMESTAMP::DATE = '2019-09-18'

4. SELECT lpep_pickup_datetime::TIMESTAMP::DATE, SUM(trip_distance)
FROM public.trips_green_taxi
GROUP BY 1
ORDER BY 2 DESC
;

5. WITH taxi AS (
    SELECT * FROM public.trips_green_taxi
    WHERE lpep_pickup_datetime::TIMESTAMP::DATE = '2019-09-18'
), 
zone AS (
    SELECT "Borough", "LocationID" FROM public.taxi_zone_lookup
    WHERE "Borough" <> 'Unknown'
)
SELECT 
    "Borough", 
    SUM(total_amount) 
FROM taxi
LEFT JOIN zone ON taxi."PULocationID" = zone."LocationID"
GROUP BY 1
ORDER BY 2 DESC

6. WITH taxi AS (
	SELECT * FROM public.trips_green_taxi
	WHERE TO_CHAR(lpep_pickup_datetime::TIMESTAMP::DATE, 'YYYY-MM') = '2019-09'
),
zone AS (
	SELECT * FROM public.taxi_zone_lookup
	WHERE "Zone" = 'Astoria'
),
pickup_astoria AS (
	SELECT * FROM taxi
	INNER JOIN zone ON taxi."PULocationID" = zone."LocationID"
)
SELECT taxi_zone_lookup."Zone", SUM(tip_amount) FROM pickup_astoria
INNER JOIN public.taxi_zone_lookup ON pickup_astoria."DOLocationID" = taxi_zone_lookup."LocationID"
GROUP BY 1
ORDER BY 2 DESC
;


7. Terraform output

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_storage_bucket.zoomcamp_bucket will be created
  + resource "google_storage_bucket" "zoomcamp_bucket" {
      + effective_labels            = (known after apply)
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "ASIA-SOUTHEAST2"
      + name                        = "okza_zoomcamp_data"
      + project                     = (known after apply)
      + public_access_prevention    = (known after apply)
      + rpo                         = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + terraform_labels            = (known after apply)
      + uniform_bucket_level_access = (known after apply)
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "AbortIncompleteMultipartUpload"
            }
          + condition {
              + age                   = 1
              + matches_prefix        = []
              + matches_storage_class = []
              + matches_suffix        = []
              + with_state            = (known after apply)
            }
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_storage_bucket.zoomcamp_bucket: Creating...
google_storage_bucket.zoomcamp_bucket: Creation complete after 2s [id=okza_zoomcamp_data]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```