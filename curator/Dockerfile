FROM alpine

LABEL vendor="JobTeaser" \
      com.jobteaser.version="1.0.1" \
      com.jobteaser.release-date="2018-09-17" \
      maintainer="dev@jobteaser.com"

ENV CURATOR_VERSION 5.5.4

RUN apk --no-cache add python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install elasticsearch-curator==${CURATOR_VERSION}

WORKDIR /usr/src/app

COPY src/requirements.txt .
RUN pip3 install --no-cache -r requirements.txt

COPY src /usr/src/app

ENTRYPOINT ["/usr/bin/curator"]
