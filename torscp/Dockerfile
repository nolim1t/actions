FROM debian:stable-slim

LABEL "maintainer"="nolim1t <nolim1t@pm.me>"
LABEL "repository"="https://github.com/nolim1t/actions"
LABEL "version"="0.0.1"

LABEL "com.github.actions.name"="SCP TOR Deploy"
LABEL "com.github.actions.description"="Deploy a directory to SCP over TOR"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="orange"

RUN apt-get update && apt-get install -y \
    openssh-client netcat tor && \
    rm -Rf /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

