FROM bitnami/minideb:latest as builder
 
RUN install_packages \
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
    && git config --global http.sslVerify false \
    && git clone -b fix/support-eu-servers https://github.com/matsprea/console-client.git \
    && cd console-client/pCloudCC \
    && cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr . \
    && make pclsync mbedtls install/strip

FROM bitnami/minideb:latest

RUN install_packages \
       expect \
       fuse \
       lsb-release

COPY --from=builder /usr/bin/pcloudcc /usr/bin/pcloudcc
COPY --from=builder /usr/lib/libpcloudcc_lib.so /usr/lib/libpcloudcc_lib.so

COPY pcloudcc_start.exp /usr/bin/

STOPSIGNAL SIGKILL

CMD [ "pcloudcc_start.exp" ]
