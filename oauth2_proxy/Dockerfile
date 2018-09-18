FROM alpine

LABEL vendor="JobTeaser" \
      com.jobteaser.version="1.0.0" \
      com.jobteaser.release-date="2018-08-16" \
      maintainer="dev@jobteaser.com"

RUN apk add --no-cache --virtual=build-dependencies ca-certificates curl

ENV OAUTH2_PROXY_VERSION 2.2

RUN curl -sSLJ https://github.com/bitly/oauth2_proxy/releases/download/v$OAUTH2_PROXY_VERSION/oauth2_proxy-$OAUTH2_PROXY_VERSION.0.linux-amd64.go1.8.1.tar.gz \
  | tar -xzf - -C /usr/local/bin --strip-components=1

EXPOSE 8080 4180
ENTRYPOINT [ "oauth2_proxy" ]
CMD [ "--upstream=http://0.0.0.0:8080/", "--http-address=0.0.0.0:4180" ]
