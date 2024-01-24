import polars as pl
from sqlalchemy import create_engine, Engine
import os

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
    def __init__(self):
        pass 

    def download(self, url: str):
        pass

    def read(self, url: str):
        pass

    def write(self, table: str):
        pass 


if __name__ == "__main__":
    pass