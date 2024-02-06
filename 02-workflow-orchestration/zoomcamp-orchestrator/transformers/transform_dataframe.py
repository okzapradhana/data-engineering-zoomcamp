import pandas as pd
import re

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

def convert_column_to_lowercase(columns: []):
    converted_cols = []
    for column in columns:
        result = re.sub("([a-z])([A-Z])", r"\1_\2", column)
        result = re.sub("([A-Z]{2})([a-zA-Z])", r"\1_\2", result)
        converted_cols.append(result.lower())
    return converted_cols

@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    # Specify your transformation logic here
    data.columns = convert_column_to_lowercase(data.columns)
    filtered_data = data[(data['passenger_count'] > 0.0)]
    filtered_data = filtered_data[(filtered_data['trip_distance'] > 0.0)]

    filtered_data['lpep_pickup_date'] = filtered_data['lpep_pickup_datetime'].dt.date

    return filtered_data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

@test
def test_column(output, *args) -> None:
    assert "vendor_id" in output.columns, "Column 'vendor_id' is not exist!"

@test
def test_passenger_count(output, *args) -> None:
    assert all(output['passenger_count'] > 0.0), "Some of passenger count are zero!"

@test
def test_trip_distance_count(output, *args) -> None:
    assert all(output['trip_distance'] > 0.0), "Some of trip distance are zero!"
