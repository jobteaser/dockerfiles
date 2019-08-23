FROM ubuntu:18.04

LABEL vendor="Jobteaser"
LABEL maintainer="foundation@jobteaser.com"

RUN apt-get upgrade -y && \
    apt-get update -y && \
    apt-get install -y \
	            --no-install-recommends \
	            curl \
	            bash \
	            dnsutils \
	            traceroute \
	            inetutils-ping \
	            vim \
	            socat

ENTRYPOINT ["/bin/bash"]
