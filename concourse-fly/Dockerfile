FROM alpine:latest

LABEL vendor="JobTeaser" \
      com.jobteaser.version="0.1.0" \
      com.jobteaser.release-data="2018-03-28" \
      maintainer="dev@jobteaser.com"

ENV FLY_VERSION="3.8.0"

RUN apk add --no-cache bash jq curl && \
	curl -L -o /usr/local/bin/fly \
	https://github.com/concourse/concourse/releases/download/v${FLY_VERSION}/fly_linux_amd64 && \
	chmod +x /usr/local/bin/fly

CMD ["bash"]
