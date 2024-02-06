from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigKey, ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
from os import path
import os
import pyarrow as pa
import pyarrow.parquet as pq

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

def get_google_creds_path():
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'
    config = ConfigFileLoader(config_path, config_profile)

    # https://docs.mage.ai/design/data-loading
    google_creds_path = config[ConfigKey.GOOGLE_SERVICE_ACC_KEY_FILEPATH]

    return google_creds_path

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = get_google_creds_path()

@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a Google Cloud Storage bucket.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    
    table = pa.Table.from_pandas(df)

    root_path = "{bucket}/{table_name}".format(bucket="okza_zoomcamp_data", table_name="green_taxi")
    gcs = pa.fs.GcsFileSystem()

    # By default will write to Local filesystem
    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=["lpep_pickup_date"],
        filesystem=gcs
    )

