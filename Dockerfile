FROM python:alpine AS venv

COPY requirements.txt requirements.txt

RUN set -ex \
    && apk --update upgrade \
    && apk --update add --no-cache python3-dev \
    py3-pillow \
    py3-ruamel.yaml \
    libmagic \
    ffmpeg \
    git \
    gcc \
    zlib-dev \
    jpeg-dev \
    musl-dev \
    libffi-dev \
    openssl-dev \
    libwebp-dev \
    && python -m venv --copies /app/venv \
    && . /app/venv/bin/activate \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir -r requirements.txt \
    && pip3 install --no-deps --force-reinstall Pillow \
    && pip3 install --ignore-installed PyYAML TgCrypto
    
FROM python:alpine AS prod

COPY --from=venv /app/venv /app/venv/

ENV LANG=C.UTF-8 \
    TZ=Asia/Shanghai \
    PATH=/app/venv/bin:$PATH

RUN set -ex \
    && apk --update upgrade \
    && apk --update add --no-cache tzdata libmagic ffmpeg \
    && rm -rf /tmp/* /var/cache/apk/* /var/lib/apk/lists/* \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && mkdir -p /root/.ehforwarderbot/profiles/default/blueset.telegram /root/.ehforwarderbot/modules/

ENTRYPOINT ["ehforwarderbot"]