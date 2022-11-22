FROM python:3.9-alpine 

ENV TZ Asia/Shanghai

WORKDIR /app

COPY requirements.txt /app

RUN set -x \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update -f \
    && apk upgrade \
    && apk --no-cache add -f build-base \
                             libffi-dev \
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
    && rm -rf /var/cache/apk/* \            
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf ~/.cache
    
ENTRYPOINT [ "ehforwarderbot" ]
