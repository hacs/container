FROM python:3.8.5-alpine3.12

RUN \
    apk add --no-cache \
        git \
        make \
    \
    && apk add --no-cache --virtual .build-deps  \
        build-base \
        libffi-dev \
        openssl-dev \
        python3-dev \
    \
    && git clone https://github.com/hacs/integration.git /tmp/integration \
    && cd /tmp/integration \
    && make init \
    \
    && rm -rf /tmp/integration \
	&& apk del --no-network .build-deps \
	\
	&& find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' \;