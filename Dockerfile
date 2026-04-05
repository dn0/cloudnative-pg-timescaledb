FROM ghcr.io/cloudnative-pg/postgresql:17.9-202603300836-system-bookworm@sha256:0d0f658b0d7bb8a0a53e2c64b4cd463a34bc52d16d49849aa8013978064597a8

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
