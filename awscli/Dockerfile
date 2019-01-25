FROM alpine:edge

LABEL vendor="JobTeaser" \
      com.jobteaser.version="1.0.0" \
      com.jobteaser.release-date="2019-01-25" \
      maintainer="dev@jobteaser.com"

RUN apk --no-cache add \
	curl \
	py-pip && \
	pip install --upgrade pip awscli && \
	mkdir /root/.aws
