FROM alpine:3.8

LABEL vendor="JobTeaser" \
      com.jobteaser.version="0.0.1" \
      com.jobteaser.release-date="2018-12-01" \
      maintainer="opensource@jobteaser.com"

ENV GLPI_VERSION 9.3.3
ENV FPM_CFG /etc/php7/php-fpm.conf
ENV PHP_CFG /etc/php7/php.ini

RUN apk add --no-cache \
  php7-mcrypt \
  php7-soap \
  php7-openssl \
  php7-gmp \
  php7-pdo_odbc \
  php7-json \
  php7-dom \
  php7-pdo \
  php7-zip \
  php7-mysqli \
  php7-sqlite3 \
  php7-pdo_pgsql \
  php7-bcmath \
  php7-gd \
  php7-odbc \
  php7-pdo_mysql \
  php7-pdo_sqlite \
  php7-gettext \
  php7-xmlreader \
  php7-xmlrpc \
  php7-bz2 \
  php7-iconv \
  php7-pdo_dblib \
  php7-curl \
  php7-ctype \
  php7-fpm \
  php7-mbstring \
  php7-session \
  php7-zlib \
  php7-simplexml \
  php7-xml \
  php7-fileinfo \
  php7-cli \
  php7-dom \
  php7-imap \
  php7-ldap \
  php7-openssl \
  php7-opcache \
  php7-apcu \
  php7-redis \
  curl \
  nginx \
  openrc-doc && \
  curl -s -L -o glpi.tgz https://github.com/glpi-project/glpi/releases/download/$GLPI_VERSION/glpi-$GLPI_VERSION.tgz && \
  mkdir /opt && \
  tar -xzf glpi.tgz -C /opt && \
  rm -rf glpi.tgz && \
  addgroup -S glpi && \
  adduser -S -G glpi glpi && \
  chown -R glpi:glpi /opt/glpi/

COPY php.ini /etc/php7/php.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /opt/start.sh

WORKDIR /opt/

CMD ["sh", "/opt/start.sh"]
