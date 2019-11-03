#!/bin/bash

# Environment variables (PRIVATE_KEY, SRC, DEST)

set -e

# Try to install TOR again (wtf)
apk add tor
# Try to install netcat again
apk add netcat-openbsd
# try to install openrc again
apk add openrc

echo "Configuring TOR"
mkdir -p /etc/tor
echo "SOCKSPort 9050" > /etc/tor/torrc
echo "Log debug file /var/log/tor/debug.log" >> /etc/tor/torrc
echo "DataDirectory /var/lib/tor" >> /etc/tor/torrc
echo "ControlPort 9051" >> /etc/tor/torrc
echo "CookieAuthentication 1" >> /etc/tor/torrc
echo "RunAsDaemon 1" >> /etc/tor/torrc

echo "Setting permissions for TOR directory"
chown -R root.root /var/lib/tor
chmod 700 /var/lib/tor


echo "Attempting to start TOR"
/usr/bin/tor -f /etc/tor/torrc --runasdaemon 1 || echo "Tor failed to start?!"


SSH_PATH="$HOME/.ssh"

mkdir -p "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "StrictHostKeyChecking=no" >> "$SSH_PATH/config"
# Use netcat to enterface with TOR
echo "Host *.onion" >> "$SSH_PATH/config"
echo "    ProxyCommand /usr/bin/nc -x localhost:9050 %h %p" >> "$SSH_PATH/config"

echo "$PRIVATE_KEY" > "$SSH_PATH/deploy_key"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"

eval $(ssh-agent)
ssh-add "$SSH_PATH/deploy_key"

echo "Wait about 20 seconds for TOR to bootstrap"
sleep 20


# do SCP
echo "Copying files via SCP"
scp -v -o "ProxyCommand nc -x localhost:9050 %h %p" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -r $SRC $DEST
