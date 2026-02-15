FROM ghcr.io/cloudnative-pg/postgresql:17.7-202602090816-system-bookworm@sha256:a50e0db0f9ffed23fd6d6c5570eebb2a0e4201a0835b90a25da983c276ee1078

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
