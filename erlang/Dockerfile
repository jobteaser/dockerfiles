
# Arguments
ARG erlang_version="22"

# Build
FROM erlang:${erlang_version}-alpine

LABEL vendor="JobTeaser"
LABEL maintainer="opensource@jobteaser.com"

RUN apk add --no-cache build-base git clang icu-dev
