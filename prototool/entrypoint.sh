#!/bin/sh

USER_ID=${LOCAL_USER_ID:-9001}
adduser -S -D -h /home/prototool -u "${USER_ID}" prototool
exec /sbin/su-exec prototool /bin/sh "$@"
