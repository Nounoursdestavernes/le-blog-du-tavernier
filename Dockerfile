FROM python:3.10 AS builder

RUN mkdir /code
WORKDIR /code
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY src/ .
RUN mkdocs build


FROM nginx:latest
COPY --from=builder /code/site /usr/share/nginx/html