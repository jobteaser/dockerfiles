FROM ubuntu:14.04

LABEL vendor="JobTeaser" \
  com.jobteaser.version="0.2.0" \
  com.jobteaser.release-date="2018-01-29" \
  maintainer="dev@jobteaser.com"

RUN apt-get update -qq && apt-get install -qq -y \
  libpq-dev qt5-default libqt5webkit5-dev git \
  gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
  software-properties-common python-software-properties \
  libreadline-dev libmysqlclient-dev curl \
  libcurl3 libcurl3-gnutls libcurl4-openssl-dev \
  imagemagick wget unzip

ENV CHROMEDRIVER_VERSION="2.31" \
  CHROMEDRIVER_DIR="/chromedriver" \
  PATH="$CHROMEDRIVER_DIR:$PATH" \
  CONFIGURE_OPTS="--disable-install-doc" \
  PATH="/usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH" \
  PATH="/usr/local/rbenv/bin:$PATH" \
  RBENV_ROOT="/usr/local/rbenv"

RUN git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv \
  && git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
  && git clone git://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset \
  && /usr/local/rbenv/plugins/ruby-build/install.sh \
  && echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
  && echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh \
  && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh \
  && echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc \
  && echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc \
  && echo 'eval "$(rbenv init -)"' >> /root/.bashrc \
  && eval "$(rbenv init -)"; rbenv install 2.3.4 \
  && eval "$(rbenv init -)"; rbenv global 2.3.4 \
  && eval "$(rbenv init -)"; gem update --system \
  && eval "$(rbenv init -)"; gem install bundler --conservative

RUN apt-get purge nodejs npm \
  && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
  && apt-get install -y nodejs

RUN mkdir $CHROMEDRIVER_DIR \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && apt-get update -y \
  && apt-get install -y google-chrome-stable \
  && wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
  &&  unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR
