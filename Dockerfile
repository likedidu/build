FROM alpine:latest 

ENV TZ Asia/Shanghai

WORKDIR /app

COPY requirements.txt /app

RUN set -x \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f libffi-dev \
                             openssl-dev \
                             jpeg-dev \
                             zlib-dev \
                             libmagic \
                             libwebp \
                             libwebp-dev \ 
                             ffmpeg \
                             cairo \
                             git \
                             freetype-dev \
                             openjpeg-dev \
                             cairo-dev \
                             py3-pillow \
    && rm -rf /var/cache/apk/* \ 
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir -r requirements.txt \
    && rm -rf ~/.cache
    
ENTRYPOINT [ "ehforwarderbot" ]
