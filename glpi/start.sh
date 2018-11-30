#!/usr/bin/env sh

php-fpm7 --fpm-config $FPM_CFG -c $PHP_CFG
exec nginx
