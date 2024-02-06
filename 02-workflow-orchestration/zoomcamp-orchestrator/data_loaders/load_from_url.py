import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    dfs = []

    for month in [10, 11, 12]:
        url = f'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2020-{month}.parquet'
        # parquet file has schema on each footer so we don't need to explicitly set the schema, unlike the csv one
        dfs.append(pd.read_parquet(url))
    
    return pd.concat(dfs)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
