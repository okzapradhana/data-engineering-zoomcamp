MONTHS=('01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12')
DESTINATION_BUCKET=okza_zoomcamp_data_v2/04-analytics-engineering
GOOGLE_CREDS_FILE=$(pwd)/de-zoomcamp-speed.json
DATA_DIR=$(pwd)/data

echo "Creating directory at $DATA_DIR, skipping if exists"
mkdir -p $DATA_DIR

# USING SERVICE ACCOUNT TO AUTH
gcloud auth activate-service-account --key-file=$GOOGLE_CREDS_FILE

for MONTH in "${MONTHS[@]}"
do
    FILEPATH="$DATA_DIR/fhv_tripdata_2019-$MONTH.parquet"
    if [ -f $FILEPATH ]; then
        echo "$FILEPATH is already exist! No need to download again"
    else
        echo "Downloading FHV Tripdata 2019-$MONTH"
        wget "https://d37ci6vzurychx.cloudfront.net/trip-data/fhv_tripdata_2019-$MONTH.parquet" -P $DATA_DIR
    fi
done

# UPLOAD FILES TO GCS
gsutil -m cp $DATA_DIR/* gs://$DESTINATION_BUCKET