FROM debian:bullseye as builder
 
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends \
       cmake \
       g++ \
       git \
       libboost-program-options-dev \
       libboost-system-dev \
       libcurl4-gnutls-dev \
       libfuse-dev \
       libudev-dev \
       make \
       zlib1g-dev \
    && cd /usr/src \
    && git clone -b fix/support-eu-servers https://github.com/matsprea/console-client.gitt \
    && cd console-client/pCloudCC \
    && cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr . \
    && make pclsync mbedtls install/strip

FROM debian:bullseye

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y --no-install-recommends \
       fuse \
       lsb-release \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/bin/pcloudcc /usr/bin/pcloudcc
COPY --from=builder /usr/lib/libpcloudcc_lib.so /usr/lib/libpcloudcc_lib.so

STOPSIGNAL SIGKILL

CMD [ "pcloudcc" ]
