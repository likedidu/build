FROM python:3.9-alpine 

ENV TZ Asia/Shanghai

WORKDIR /app

COPY requirements.txt /app

RUN apk --no-cache --virtual build add sed build-base libffi-dev openssl-dev &&\
    apk --no-cache add jpeg-dev zlib-dev libmagic libwebp-dev ffmpeg cairo &&\
    pip install -U pip &&\
    pip install -r requirements.txt &&\
    rm -rf ~/.cache &&\
    apk del build  &&\

ENTRYPOINT [ "ehforwarderbot" ]
