FROM golang:1.12.0-stretch

LABEL vendor="JobTeaser" \
      com.jobteaser.version="1.12.0" \
      com.jobteaser.release-date="2019-03-08" \
      maintainer="dev@jobteaser.com"

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-client \
  && rm -rf /var/lib/apt/lists/*

ENV LIBRDKAFKA_VERSION=1.0.0

RUN curl -Lk -o /root/librdkafka-${LIBRDKAFKA_VERSION}.tar.gz https://github.com/edenhill/librdkafka/archive/v${LIBRDKAFKA_VERSION}.tar.gz && \
      tar -xzf /root/librdkafka-${LIBRDKAFKA_VERSION}.tar.gz -C /root && \
      cd /root/librdkafka-${LIBRDKAFKA_VERSION} && \
      ./configure --prefix /usr && make && make install && make clean && ./configure --clean
