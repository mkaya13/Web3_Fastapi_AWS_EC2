FROM python:3.9-slim-buster

WORKDIR /usr/src/project

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update && apt-get -y install \
    netcat gcc postgresql \
    && apt-get clean

RUN pip install --upgrade pip
COPY ./requirements.txt /usr/src/project
RUN pip install -r requirements.txt

COPY . /usr/src/project

CMD gunicorn -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000 app.main:app