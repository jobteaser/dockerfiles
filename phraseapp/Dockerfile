FROM ubuntu:20.04

LABEL vendor="JobTeaser"
LABEL maintainer="devex@jobteaser.com"

ENV DEBIAN_FRONTEND noninteractive

ENV PHRASECLI_VERSION=2.0.25
ENV BINARY_LOCATION=https://github.com/phrase/phrase-cli/releases/download/$PHRASECLI_VERSION/phrase_linux_amd64.tar.gz
ENV NODE_VERSION 10.16.3

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        git \
    && \
    mkdir -p /usr/local/etc && \
    ( \
        cd /tmp && \
        wget -q --no-check-certificate $BINARY_LOCATION && \
        tar -xzf phrase_linux_amd64.tar.gz && \
        mv phrase_linux_amd64 /usr/local/bin/phrase && \
        rm phrase_linux_amd64.tar.gz && \
        wget -q https://nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz && \
        tar -xzf node-v$NODE_VERSION-linux-x64.tar.gz && \
        rm node-v$NODE_VERSION-linux-x64.tar.gz && \
        cd node-v$NODE_VERSION-linux-x64 && \
        cp -r bin /usr/local/ && \
        cp -r include /usr/local/ && \
        cp -r lib /usr/local/ && \
        cp -r share /usr/local/ && \
        rm -rf node-v$NODE_VERSION-linux-x64 \
    ) && \
    apt-get autoremove -y && \
    apt-get clean -y