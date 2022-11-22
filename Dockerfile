FROM python:3.9-alpine 

ENV TZ "Asia/Shanghai"

WORKDIR /app

COPY requirements.txt /app

RUN set -x \
    && apk update -f \
    && apk upgrade \ 
    && apk add --no-cache -f libffi-dev \
                             openssl-dev \
                             jpeg-dev \
                             zlib-dev \
                             libmagic \
                             libwebp \
                             libwebp-dev \ 
                             ffmpeg \
                             cairo \
                             freetype-dev \
                             openjpeg-dev \
                             cairo-dev \
    && apk add --no-cache --virtual .build-deps git build-base \            
    && rm -rf /var/cache/apk/* \            
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf ~/.cache \
    && apk del .build-deps
    
ENTRYPOINT [ "ehforwarderbot" ]
