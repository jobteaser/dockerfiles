# Courtesy of https://github.com/gearnode/dnsmasq
FROM ubuntu:20.04 AS builder

ARG DNSMASQ_REPOSITORY=http://thekelleys.org.uk/git/dnsmasq.git
ARG VERSION=2.82

RUN apt-get update && \
  apt-get install -y make git gcc && \
  git clone ${DNSMASQ_REPOSITORY} /tmp/dnsmasq && \
  cd /tmp/dnsmasq && \
  git checkout -b ${VERSION} && \
  make install

FROM ubuntu:20.04

LABEL version=${VERSION} \
  maintainer=squad-devex@jobteaser.com

COPY --from=builder /usr/local/sbin/dnsmasq /usr/local/sbin/dnsmasq

EXPOSE 53 53/udp

ENTRYPOINT ["dnsmasq", "-k"]
