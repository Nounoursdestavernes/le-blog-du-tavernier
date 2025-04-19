FROM python:3.10 AS builder

RUN mkdir /code
WORKDIR /code
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src/ .
RUN mkdocs build


FROM nginx:1.27.5-alpine-slim
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /code/site /usr/share/nginx/html
