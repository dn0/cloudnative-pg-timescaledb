FROM ghcr.io/cloudnative-pg/postgresql:17.5-19-bookworm@sha256:f3e0b175104e36bb99a2d9a8fb86f940aaa713a3717f2793aafb1e74adeaeecc

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
