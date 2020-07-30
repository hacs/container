FROM python:3.7.8-alpine3.12

RUN \
    apk add --no-cache \
        git \
        make \
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
	\
	&& find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' \;