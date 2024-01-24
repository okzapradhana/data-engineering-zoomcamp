import polars as pl
from sqlalchemy import create_engine, Engine
import os
import argparse
from urllib.request import urlretrieve

class ConnectionManager(object):
    def __init__(self, user: str, password: str, db: str, host: str, port: int):
        self.user = user
        self.password = password
        self.db = db
        self.host = host
        self.port = port

    def get_engine(self) -> Engine:
        return create_engine(self.get_conn_uri)

    def get_conn_uri(self) -> str:
        return f"postgresql://{self.user}:{self.password}@{self.host}:{self.port}/{self.db}"


class BaseIngestion(object):
    def __init__(self, url: str, filepath: str, table: str):
        self.url = url
        self.filepath = filepath
        self.table = table

    def download(self):
        if os.path.exists(self.filepath) is False:
            urlretrieve(self.url, self.filepath)

    def read(self) -> pl.DataFrame:
        self.download()
        if self.filepath.endswith('.parquet') or self.filepath.endswith('.pq'):
            df = pl.read_parquet(self.filepath, low_memory=True)
        elif self.filepath.endswith('.csv'):
            df = pl.read_csv(self.filepath)
        else:
            raise ValueError(f"{self.filepath.split('.')[-1]} is not supported!")
        
        return df
            
    def write_sql(self, df: pl.DataFrame, conn_uri: str):
        df.write_database(self.table, conn_uri, if_table_exists="replace")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument("-U", "--user", help="Postgres user")
    parser.add_argument("-p", "--password", help="Postgres password")
    parser.add_argument("-db", "--database", help="Postgres database")
    parser.add_argument("-H", "--host", help="Postgres host", default="localhost")
    parser.add_argument("-P", "--port", help="Postgres port", default=5432)
    parser.add_argument("-f", "--filepath", help="Filepath to read")
    parser.add_argument("-t", "--table", help="Table name to write/update")
    parser.add_argument("-u", "--url", help="URL data source")
    
    args = parser.parse_args()

    ingestion_sql = BaseIngestion(args.url, args.filepath, args.table)
    conn_manager = ConnectionManager(args.user, args.password, args.db, args.host, args.port)
    conn_uri = conn_manager.get_conn_uri()

    df = ingestion_sql.read()
    ingestion_sql.write_sql(df, conn_uri)