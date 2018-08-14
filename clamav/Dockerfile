FROM alpine:latest

RUN apk add --no-cache bash clamav rsyslog wget clamav-libunrar findutils

ENV CLAMSCAN_LOGPATH="/var/log/clamav.log"
COPY start /start

ENTRYPOINT ["/start"]
