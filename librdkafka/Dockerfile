FROM alpine:3.9

ENV LIBRESSL_VERSION=2.7
ENV LIBRDKAFKA_VERSION=1.0.0

RUN apk add --no-cache bash curl git openssh openssl yajl-dev zlib-dev cyrus-sasl-dev openssl-dev build-base coreutils && \
  apk add libressl${LIBRESSL_VERSION}-libcrypto libressl${LIBRESSL_VERSION}-libssl --update-cache --repository http://nl.alpinelinux.org/alpine/edge/main

RUN curl -Lk -o /root/librdkafka-${LIBRDKAFKA_VERSION}.tar.gz https://github.com/edenhill/librdkafka/archive/v${LIBRDKAFKA_VERSION}.tar.gz && \
      tar -xzf /root/librdkafka-${LIBRDKAFKA_VERSION}.tar.gz -C /root && \
      cd /root/librdkafka-${LIBRDKAFKA_VERSION} && \
      ./configure --prefix /usr && make && make install && make clean && ./configure --clean
