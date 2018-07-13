FROM debian:jessie

ENV CHROMEDRIVER_VERSION "2.38"
ENV GOOGLECHROME_VERSION "67.0.3396.99-1"

ENV CHROMEDRIVER_PORT "9515"

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
  && apt-get -yqq install google-chrome-stable=$GOOGLECHROME_VERSION

CMD ["chromedriver","--port=$CHROMEDRIVER_PORT"]
