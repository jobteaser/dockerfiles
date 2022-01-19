FROM ubuntu:20.04

LABEL vendor="Jobteaser"
LABEL maintainer="foundation@jobteaser.com"

ENV KAFKA_VERSION 1.0.0
ENV SCALA_VERSION 2.12

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      bash \
      ca-cacert \
      curl \
      dnsutils \
      inetutils-ping \
      mtr-tiny \
      netcat-openbsd \
      openjdk-11-jdk \
      postgresql-client \
      socat \
      traceroute \
      wget \
      redis-server \
    && \
    ( \
      cd /tmp && \
      wget -q https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
      tar -xzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
      mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka \
    )

ENTRYPOINT ["/bin/bash"]
