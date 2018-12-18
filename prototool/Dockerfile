FROM golang:1.11.0-alpine3.8 AS build

ENV PROTOTOOL_VERSION=1.3.0
ENV PROTOC_VERSION=3.6.1
ENV PROTOC_GEN_GO_VERSION=1.2.0

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

FROM alpine:3.8

LABEL vendor="Jobteaser" \
      com.jobteaser.version="0.1.0" \
      com.jobteaser.release-date="2018-12-19" \
      com.jobteaser.origin="github.com/dockerfiles/prototool" \
      maintainer="dev@jobteaser.com"

RUN apk add --no-cache libc6-compat make ruby && \
  gem install grpc-tools -v '1.17' --no-ri --no-rdoc

COPY --from=build /usr/local/bin/prototool /usr/local/bin/prototool
COPY --from=build /go/bin/protoc-gen-go /usr/local/bin/protoc-gen-go
COPY --from=build /usr/local/go /usr/local/go

ENV PATH /usr/local/go/bin:$PATH

RUN chmod +x /usr/local/bin/prototool && \
  chmod +x /usr/local/bin/protoc-gen-go

# USER nobody:nobody

ENTRYPOINT ["prototool"]
