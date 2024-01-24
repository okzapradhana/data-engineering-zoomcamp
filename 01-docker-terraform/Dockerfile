FROM python:3.9.6

WORKDIR /app

COPY ingestion.py ingestion.py
COPY requirements.txt requirements

RUN pip install -r requirements.txt

ENTRYPOINT [ "python", "ingestion.py" ]