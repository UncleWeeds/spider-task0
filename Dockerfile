FROM python:3.8-slim

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
