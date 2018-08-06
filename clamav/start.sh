#!/usr/bin/env sh

[ -f /var/lib/clamav/main.cvd ] || freshclam
find "$@" -print0 | xargs -0 clamscan --log="${CLAMSCAN_LOGPATH}"
