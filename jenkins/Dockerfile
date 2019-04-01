FROM jenkins/jenkins:lts
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

## Configure timezone to Europe/Paris
USER root
RUN export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    apt-get update -qqy && apt-get install -qqy --no-install-recommends tzdata \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ENV TZ Europe/Paris

USER jenkins:jenkins
