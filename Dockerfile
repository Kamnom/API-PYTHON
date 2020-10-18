FROM postgres:alpine

RUN apk add --no-cache python3-dev \
    && pip3 install --upgrade pip


WORKDIR /api

COPY . /api

RUN pip3 --no-cache-dir install -r requirements.txt

RUN --name postgresql -e POSTGRES_PASSWORD=123456789 -d -p 54321:54321 postgres:alpine



CMD ["python3","source/api.py"]
