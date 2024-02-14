import io
import pandas as pd
import polars as pl
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
    for i in ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']:
        url = f'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-{i}.parquet'
        print(f"Reading {url}")
        df = pl.read_parquet(url)
        dfs.append(df)

    return pl.concat(dfs)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
