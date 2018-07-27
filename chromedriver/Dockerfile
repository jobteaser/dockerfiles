# Dockerfile for building the chromedriver image of jobcrawler
FROM debian:jessie

LABEL vendor="JobTeaser" \
      com.jobteaser.version="0.1.0" \
      com.jobteaser.release-date="2018-07-13" \
      maintainer="dev@jobteaser.com"

ENV CHROMEDRIVER_VERSION "2.38"

# Download required packages
RUN apt-get update && apt-get install -yqq \
  curl \
  unzip \
  gnupg2

# Download and move chromedriver binary
RUN mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION \
  && curl -sS -o /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip \
  && unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION \
  && rm /tmp/chromedriver_linux64.zip \
  && chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver \
  && ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# Set proper source to download google-chrome-stable package and install it
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get -yqq update \
  && apt-get -yqq install google-chrome-stable

# Chromedriver port
EXPOSE 9515
