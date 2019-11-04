# SSH over TOR

## About

This github action allows for executing a command on a remote host over TOR (clearnet is fine, but there is better and faster options).


## Environment variables

* PRIVATE_KEY (This is the SSH private key. Recommended that this is a secret)
* USERHOST (The SSH host)
* CMD (The SSH command)

