FROM alpine:3.12

RUN apk add python3-dev
RUN apk add py3-pip && pip3 install --upgrade pip
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev

RUN pip3 install psycopg2-binary

WORKDIR /api

COPY . /api

RUN pip3  install -r requirements.txt



CMD ["python3","source/api.py"]


##docker tag f64706fbd427 grc.io/enduring-hue-292820/f64706fbd427:psqldb
##docker push gcr.io/enduring-hue-292820/f64706fbd427

