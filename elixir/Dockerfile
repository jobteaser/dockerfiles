FROM jobteaser/circleci-docker-build:latest

LABEL vendor="JobTeaser"
LABEL maintainer="opensource@jobteaser.com"

# Erlang Solutions build
ENV ERLANG_VERSION 26.1.2

ENV ELIXIR_VERSION 1.16.0
ENV NODE_VERSION 18.12.0

ENV UBUNTU_VERSION focal

ENV DEBIAN_FRONTEND noninteractive

ENV LANG C.UTF-8

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      bash wget ca-certificates unzip git openssh-client docker.io make clang libicu-dev && \
    update-ca-certificates && \
    ( \
      cd /tmp && \
      wget -q https://nodejs.org/download/release/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz && \
      tar -xzf node-v${NODE_VERSION}-linux-x64.tar.gz && \
      rm node-v${NODE_VERSION}-linux-x64.tar.gz && \
      cd node-v${NODE_VERSION}-linux-x64 && \
      cp -r bin /usr/local/ && \
      cp -r include /usr/local/ && \
      cp -r lib /usr/local/ && \
      cp -r share /usr/local/ && \
      rm -rf node-v${NODE_VERSION}-linux-x64 \
    ) && \
    ( \
      cd /tmp && \
      wget -q https://binaries2.erlang-solutions.com/ubuntu/pool/contrib/e/esl-erlang/esl-erlang_${ERLANG_VERSION}-1~ubuntu~${UBUNTU_VERSION}_amd64.deb && \
      apt install -y ./esl-erlang_${ERLANG_VERSION}-1~ubuntu~${UBUNTU_VERSION}_amd64.deb && \
      rm esl-erlang_${ERLANG_VERSION}-1~ubuntu~${UBUNTU_VERSION}_amd64.deb \
    ) && \
    ( \
      cd /tmp && \
      wget -q https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.zip && \
      mkdir -p /usr/local/src && \
      unzip v${ELIXIR_VERSION}.zip && \
      mv elixir-${ELIXIR_VERSION} /usr/local/src/elixir && \
      rm -f v${ELIXIR_VERSION}.zip && \
      cd /usr/local/src/elixir && \
      make install clean \
    ) && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get remove --purge -y \
      wget unzip && \
    apt-get autoremove -y && \
    apt-get clean -y
