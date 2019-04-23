FROM docker:stable-dind
LABEL vendor=JobTeaser com.jobteaser.version=0.1.0 maintainer=dev@jobteaser.com
ENV DOCKER_BUILDKIT=1 \
    composeVersion=1.23.1
RUN apk add -u --no-cache  make py-pip git openssh-client
RUN pip install --no-cache-dir -U pip docker-compose==$composeVersion
