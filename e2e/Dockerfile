FROM jobteaser/circleci-docker-build:latest

LABEL vendor="JobTeaser"
LABEL maintainer="qa@jobteaser.com"

ENV NODE_ENV CI

# Node.js
ENV NODE_VERSION 12.12.0
ENV NPM_VERSION 6.11.3

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
                    --no-install-recommends \
                    bash \
                    ca-certificates \
                    curl \
                    wget && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /usr/local/etc && \
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
    npm install -g npm@$NPM_VERSION


# Java (required for allure cli)
RUN apt-get update &&\
    apt-get install -y openjdk-8-jre

# Clean up
RUN apt-get autoremove -y && \
    apt-get clean -y
