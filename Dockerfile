FROM python:3.9-alpine 

ENV TZ "Asia/Shanghai"

WORKDIR /app

COPY requirements.txt /app

RUN apk add --no-cache -f ca-certificates \
                          tiff \
                          libmagic \
                          libwebp \
                          zlib-dev \
                          ffmpeg \
                          freetype \
                          openjpeg \
                          openblas \
                          cairo \
    && apk add --no-cache --virtual .build-deps git build-base \            
    && rm -rf /var/cache/apk/* \            
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf ~/.cache \
    && apk del .build-deps
    
ENTRYPOINT [ "ehforwarderbot" ]
