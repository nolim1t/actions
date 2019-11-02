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

check_connection() {
  if nc -vz localhost 9050 2>/dev/null; then
      ONLINE=0
  else
      ONLINE=1
  fi
}

ONLINE=1
COUNT=0

# Check tor connection for 30 seconds
while [[ $ONLINE -eq 1 ]] && [ $COUNT -lt 60 ]
do
    echo "Checking tor connection"
    check_connection
    COUNT=$((COUNT + 1))
    sleep 1
done

# Lets copy this
if [[ $ONLINE == 0 ]]; then
  echo "We are online"
  scp -r $SRC $DEST
  return 0
else
  echo "Can't connect to tor after 60 seconds"
  return 1
fi
