FROM ubuntu:18.04

LABEL vendor="JobTeaser"
LABEL maintainer="opensource@jobteaser.com"

# Erlang Solutions build
ENV ERLANG_VERSION 21.3.8.6

ENV ELIXIR_VERSION 1.7.3
ENV NODE_VERSION 9.7.0

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      bash wget ca-certificates unzip git openssh-client docker.io make clang libicu-dev && \
    ( \
      cd /tmp && \
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
    ( \
      cd /tmp && \
      wget -q https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_$ERLANG_VERSION-1~ubuntu~bionic_amd64.deb && \
      apt install -y ./esl-erlang_$ERLANG_VERSION-1~ubuntu~bionic_amd64.deb && \
      rm esl-erlang_$ERLANG_VERSION-1~ubuntu~bionic_amd64.deb \
    ) && \
    ( \
      cd /tmp && \
      wget -q https://github.com/elixir-lang/elixir/releases/download/v$ELIXIR_VERSION/Precompiled.zip && \
      unzip -d /usr/local Precompiled.zip && \
      rm Precompiled.zip \
    ) && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get remove --purge -y \
      wget unzip && \
    apt-get autoremove -y && \
    apt-get clean -y
