FROM ghcr.io/cloudnative-pg/postgresql:17.6-202509261031-system-bookworm@sha256:c3f0e4bd0ca587be8f1ebd50883163645f00ff12245e122a058d68fe3f95c53e

USER root

RUN apt-get update \
    && apt-get install -y wget lsb-release procps \
    && echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/timescaledb.list \
    && wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | gpg --dearmor -o /etc/apt/trusted.gpg.d/timescaledb.gpg \
    && apt-get update \
    && apt-get install -y "timescaledb-2-postgresql-${PG_MAJOR}" "timescaledb-toolkit-postgresql-${PG_MAJOR}" \
    && apt-get remove -y wget lsb-release \
    && rm -fr /tmp/* /var/lib/apt/lists/*

USER postgres
