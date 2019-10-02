FROM alpine

LABEL vendor="JobTeaser" \
      com.jobteaser.version="1.0.1" \
      com.jobteaser.release-date="2019-10-10" \
      maintainer="dev@jobteaser.com"

ARG CURATOR_VERSION=5.6.0
ARG PYYAML_VERSION=3.12

RUN apk --no-cache add python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install -U pyyaml==${PYYAML_VERSION} && \
    pip3 install elasticsearch-curator==${CURATOR_VERSION}

WORKDIR /usr/src/app

COPY src/requirements.txt .
RUN pip3 install --no-cache -r requirements.txt

COPY src /usr/src/app

ENTRYPOINT ["/usr/bin/curator"]
