FROM uber/prototool:1.8.0

LABEL vendor="Jobteaser" \
      maintainer="opensource@jobteaser.com"

# The official prototool image does not include the annotation proto. This RUN instruction download
# and add the annotation proto on the right place to avoid prototool configuration.
RUN \
  git clone --depth 1 https://github.com/grpc-ecosystem/grpc-gateway.git /tmp/annotations && \
  mv /tmp/annotations/third_party/googleapis/google/api /usr/include/google/api && \
  mv /tmp/annotations/third_party/googleapis/google/rpc /usr/include/google/rpc && \
  rm -rf /tmp/annotations

RUN \
  apk add --no-cache python3 build-base gcc python3-dev && \
  pip3 install --upgrade pip && \
  pip3 install grpcio~=1.21.1 && \
  pip3 install grpcio-tools~=1.21.1 && \
  pip3 install googleapis-common-protos

ENTRYPOINT ["prototool"]
