# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt  # Use --no-cache-dir to avoid cached versions

COPY . .

# Upgrade the werkzeug package
RUN pip3 install --no-cache-dir --upgrade werkzeug

CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0"]
