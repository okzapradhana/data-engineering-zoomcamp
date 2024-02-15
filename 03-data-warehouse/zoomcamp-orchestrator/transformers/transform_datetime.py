import polars as pl

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


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
    df = data.with_columns(
        (pl.col("lpep_pickup_datetime")/1000000).cast(pl.Datetime).dt.with_time_unit("ms").alias("lpep_pickup_datetime"),
        (pl.col("lpep_dropoff_datetime")/1000000).cast(pl.Datetime).dt.with_time_unit("ms").alias("lpep_dropoff_datetime"),
    )

    # df = df.with_columns(
    #     pl.col("lpep_pickup_datetime").cast(pl.Int64).alias("lpep_pickup_datetime"),
    #     pl.col("lpep_dropoff_datetime").cast(pl.Int64).alias("lpep_dropoff_datetime")
    # )

    print(df.schema)
    
    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
