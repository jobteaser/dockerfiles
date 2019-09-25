FROM ubuntu:18.04

LABEL vendor="Jobteaser"
LABEL maintainer="foundation@jobteaser.com"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      bash \
      curl \
      dnsutils \
      inetutils-ping \
      mtr-tiny \
      netcat-openbsd \
      postgresql-client \
      socat \
      traceroute \
      vim

ENTRYPOINT ["/bin/bash"]
