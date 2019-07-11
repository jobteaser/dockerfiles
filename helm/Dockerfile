FROM ubuntu:18.04

LABEL vendor="JobTeaser"
LABEL maintainer="opensource@jobteaser.com"

ENV HELM_VERSION 2.12.3

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      wget ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    ( \
      cd /tmp && \
      wget -q https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz && \
      tar -xzf helm-v$HELM_VERSION-linux-amd64.tar.gz && \
      cd linux-amd64 && \
      install -m755 helm /usr/local/bin/helm && \
      install -m755 tiller /usr/local/bin/tiller \
    ) && \
    \
    apt-get remove --purge -y \
      wget && \
    apt-get autoremove -y && \
    apt-get clean -y
