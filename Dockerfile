FROM python:3.8-slim

RUN apt-get update && \
    apt-get install -y acl

WORKDIR /home/Hospital_Server/bash

COPY bash /home/Hospital_Server/bash

WORKDIR /app

COPY requirements.txt ./

RUN pip install -r requirements.txt

COPY . .

CMD gunicorn app:app --bind 0.0.0.0:5000

# docker build -t flaskk-app .
# docker run -p 5000:5000 flaskk-app
# docker image ls
# docker container ls 
# docker container stop 'id'
