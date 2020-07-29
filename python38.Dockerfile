FROM ludeeus/container:debian-base

# Install the correct python version
ARG PYTHON_VERSION="3.8.5"
RUN \
    apt update && apt install -y --no-install-recommends --allow-downgrades \
        build-essential \
        libncursesw5-dev libssl-dev \
        libsqlite3-dev \
        tk-dev \
        libgdbm-dev \
        libc6-dev \
        libbz2-dev \
        libffi-dev \
        zlib1g-dev \
    \
    && cd /opt \
    && wget "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz" \
    && tar xzf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make altinstall \
    \
    && rm /opt/Python-${PYTHON_VERSION}.tgz \
    && rm -fr /var/lib/apt/lists/* \
    && rm -fr /tmp/* /var/{cache,log}/* \
    \
    && ln -sf /usr/local/bin/python3.8 /usr/local/bin/python3 \
    && ln -sf /usr/local/bin/python3.8 /usr/local/bin/python \
    && python --version \
    && python3 --version

# Install HACS requirements
RUN \
    git clone https://github.com/hacs/integration.git /tmp/integration \
    && cd /tmp/integration \
    && apt update && apt install -y sudo libxml2-dev libxslt-dev \
    && make init \
    \
    && rm -rf /tmp/integration \
    && rm -fr /var/lib/apt/lists/* \
    && rm -fr /tmp/* /var/{cache,log}/*