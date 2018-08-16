FROM alpine

LABEL vendor="JobTeaser" \
      com.jobteaser.version="1.0.0" \
      com.jobteaser.release-date="2018-08-16" \
      maintainer="dev@jobteaser.com"

ENV CURATOR_VERSION 5.5.4

RUN apk --no-cache add python py-pip && \
    pip install --upgrade pip && \
    pip install elasticsearch-curator==${CURATOR_VERSION}

WORKDIR /usr/src/app

COPY src/requirements.txt .
RUN pip install --no-cache -r requirements.txt

COPY src /usr/src/app

CMD ["/usr/bin/curator"]
