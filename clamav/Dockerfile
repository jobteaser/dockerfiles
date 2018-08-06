FROM alpine:latest

RUN apk add --no-cache clamav rsyslog wget clamav-libunrar findutils

ENV CLAMSCAN_LOGPATH="/var/log/clamav.log"
COPY start.sh /start.sh

ENTRYPOINT ["/start.sh"]
