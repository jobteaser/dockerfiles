FROM alpine:latest

LABEL vendor="JobTeaser" \
      com.jobteaser.version="0.1.1" \
      com.jobteaser.release-data="2018-01-10" \
      maintainer="dev@jobteaser.com"

ENV KUBECTL_VERSION="v1.9.1"
ENV HELM_VERSION="v2.7.2"

RUN apk --no-cache add --virtual .build-dependencies curl \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -o /tmp/helm.tar.gz \
    && tar -zxvf /tmp/helm.tar.gz -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf /tmp/* \
    && apk del .build-dependencies


RUN apk add --no-cache bash

CMD ["bash"]
