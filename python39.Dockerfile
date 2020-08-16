FROM python:3.9.0rc1-alpine3.12

RUN \
    # Dependencies
    apk add --no-cache \
        build-base \
        git \
        libffi-dev \
        make \
        openssl-dev \
        python3-dev \
    \
    # Install HACS requirements
    && git clone https://github.com/hacs/integration.git /tmp/integration \
    && cd /tmp/integration \
    && make init \
    \
    # Cleanup
    && rm -rf /tmp/integration \
    && rm -rf /var/cache/apk/* \
	\
	&& find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' \;