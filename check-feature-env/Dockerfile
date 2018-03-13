FROM jobteaser/k8s-tools

LABEL vendor="JobTeaser" \
      com.jobteaser.version="0.1.0" \
      com.jobteaser.release-data="2018-03-13" \
      maintainer="dev@jobteaser.com"

ENV BUNDLER_VERSION 1.16.1

RUN apk add --no-cache ca-certificates git \
  openssh-client perl ruby ruby-json

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --version "$BUNDLER_VERSION" --no-ri --no-rdoc --force && \
  bundle install && \
  rm -rf /root/.gem/

COPY . .

CMD ["bash"]
