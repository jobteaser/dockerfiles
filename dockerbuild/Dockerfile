FROM docker:latest

LABEL vendor="JobTeaser" \
      com.jobteaser.version="0.1.1" \
      com.jobteaser.release-date="2018-01-09" \
      maintainer="dev@jobteaser.com"

RUN apk add --no-cache bash

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bash"]
