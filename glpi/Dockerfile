FROM nginx:alpine

ENV GLPI_VERSION "9.4.1.1"
ENV OCS_INVENTORY_VERSION "1.6.0"

COPY resources /tmp/resources

# Following PHP extensions are required for the app to work properly
RUN apk add --update --no-cache \
  php7 \
  php7-fpm \
  php7-curl \
  php7-fileinfo \
  php7-gd \
  php7-json \
  php7-mbstring \
  php7-mysqli \
  php7-session \
  php7-zlib \
  php7-simplexml \
  php7-xml \
  php7-cli \
  php7-imap \
  php7-ldap \
  php7-openssl \
  php7-xmlrpc \
  php7-bcmath \
  php7-bz2 \
  php7-ctype \
  php7-dom \
  php7-dom \
  php7-gettext \
  php7-gmp \
  php7-iconv \
  php7-mcrypt \
  php7-odbc \
  php7-opcache \
  php7-openssl \
  php7-pdo \
  php7-pdo_dblib \
  php7-pdo_mysql \
  php7-pdo_odbc \
  php7-pdo_pgsql \
  php7-pdo_sqlite \
  php7-redis \
  php7-soap \
  php7-exif \
  php7-sqlite3 \
  php7-xmlreader \
  php7-zip \ 
  php7-apcu && \
  chown -R nginx:nginx /tmp/resources && \
  wget https://github.com/glpi-project/glpi/releases/download/${GLPI_VERSION}/glpi-${GLPI_VERSION}.tgz -P /tmp/resources && \
  mkdir -p /var/www/ && \
  mkdir -p /var/log/glpi && \
  tar -xzf /tmp/resources/glpi-${GLPI_VERSION}.tgz -C /var/www/ && \
  cp /tmp/resources/start.sh /usr/local/bin && \
  rm /etc/nginx/conf.d/*.conf && \
  cp /tmp/resources/glpi.conf /etc/nginx/conf.d/ && \
  wget https://github.com/pluginsGLPI/ocsinventoryng/releases/download/${OCS_INVENTORY_VERSION}/glpi-ocsinventoryng-${OCS_INVENTORY_VERSION}.tar.gz -P /tmp/resources && \
  tar -xzf /tmp/resources/glpi-ocsinventoryng-${OCS_INVENTORY_VERSION}.tar.gz -C /var/www/glpi/plugins && \
  chown -R nginx:nginx /var/www/glpi/ && \
  chown -R nginx:nginx /var/log/glpi/ && \
  sed -E 's/^((user|group)[[:blank:]]*=[[:blank:]]*).*/\1nginx/' -i /etc/php7/php-fpm.d/www.conf && \
  rm -r /tmp/resources && \
  echo "END"

CMD ["start.sh"]
