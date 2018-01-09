FROM docker:latest

LABEL vendor=JobTeaser
      com.jobteaser.version="0.1.0" \
      com.jobteaser.release-date="2018-01-09" \
      maintener="dev@jobteaser.com"

RUN apk add --no-cache \
                bash

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]
