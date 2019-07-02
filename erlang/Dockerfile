
# Arguments
ARG erlang_version="22"

# Build
FROM erlang:${erlang_version}

LABEL vendor="JobTeaser"
LABEL maintainer="opensource@jobteaser.com"

RUN apt-get update
RUN apt-get install -y clang libicu-dev
RUN apt-get purge -y
