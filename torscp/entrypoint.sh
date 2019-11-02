#!/bin/sh

# Environment variables (PRIVATE_KEY, SRC, DEST)

set -e

/etc/init.d/tor start

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

# Lets copy this
scp -r $SRC $DEST
