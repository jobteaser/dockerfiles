FROM alpine:edge

LABEL com.jobteaser.release-date="2018-03-25" \
      com.jobteaser.version="0.1.0" \
      maintainer="dev@jobteaser.com" \
      vendor="Jobteaser"

RUN apk add --no-cache ruby ruby-rugged

RUN gem install --no-ri --no-rdoc -v="1.0.0" licensed


