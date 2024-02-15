# 03-data-warehouse
Contains solution and works for 3rd week of DE Zoomcamp 2024.

SQL Files
Please find the SQL to accomplish the homework on `sql` folder with below explanation:
1. `sql/create_external_table.sql` used to create external table on BigQuery based on parquet files on GCS
2. `sql/create_materialized_table.sql` used to create BigQuery internal table using parquet files on GCS
3. `sql/create_partitioned_clustered_table.sql` used to create partitioned and clustered BigQuery table based on external table resulted from `sql/create_external_table.sql`