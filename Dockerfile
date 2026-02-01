FROM ghcr.io/cloudnative-pg/postgresql:17.7-202601260808-system-bookworm@sha256:f23eccef24eee7594557c57cb07c8b31660301db4355db4dc10a1dd1accff88d

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
