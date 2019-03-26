FROM golang:1.11.0-alpine3.8 AS build

ENV PROTOTOOL_VERSION=1.4.0
ENV PROTOC_VERSION=3.6.1
ENV PROTOC_GEN_GO_VERSION=1.3.1
ENV PROTOC_GEN_GRPC_GATEWAY_VERSION=1.8.5

RUN apk add --no-cache curl git libc6-compat

RUN curl -sSL https://github.com/uber/prototool/releases/download/v$PROTOTOOL_VERSION/prototool-Linux-x86_64 -o /usr/local/bin/prototool && \
  chmod +x /usr/local/bin/prototool

RUN mkdir /tmp/prototool-bootstrap && \
  echo $'protoc:\n  version:' $PROTOC_VERSION > /tmp/prototool-bootstrap/prototool.yaml && \
  echo 'syntax = "proto3";' > /tmp/prototool-bootstrap/tmp.proto && \
  prototool compile /tmp/prototool-bootstrap && \
  rm -rf /tmp/prototool-bootstrap

RUN go get github.com/golang/protobuf/... && \
  cd /go/src/github.com/golang/protobuf && \
  git checkout -b v$PROTOC_GEN_GO_VERSION && \
  go install ./protoc-gen-go

RUN go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
  cd /go/src/github.com/grpc-ecosystem/grpc-gateway && \
  git checkout -b v$PROTOC_GEN_GRPC_GATEWAY_VERSION && \
  go install ./protoc-gen-grpc-gateway

FROM alpine:3.8

LABEL vendor="Jobteaser" \
  com.jobteaser.version="1.0.0" \
  com.jobteaser.release-date="2019-01-24" \
  com.jobteaser.origin="github.com/dockerfiles/prototool" \
  maintainer="dev@jobteaser.com"

ENV GRPC_TOOLS_GEM_VERSION=1.17

RUN apk add --no-cache libc6-compat git make ruby su-exec && \
  gem install grpc-tools -v $GRPC_TOOLS_GEM_VERSION --no-ri --no-rdoc

COPY --from=build /usr/local/bin/prototool /usr/local/bin/prototool
COPY --from=build /go/bin/protoc-gen-go /usr/local/bin/protoc-gen-go
COPY --from=build /go/bin/protoc-gen-grpc-gateway /usr/local/bin/protoc-gen-grpc-gateway

ENV PATH /usr/local/go/bin:$PATH

RUN chmod +x /usr/local/bin/prototool && \
  chmod +x /usr/local/bin/protoc-gen-go && \
  chmod +x /usr/local/bin/protoc-gen-grpc-gateway

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
