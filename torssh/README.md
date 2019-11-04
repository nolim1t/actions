# SSH over TOR

## About

This github action allows for executing a command on a remote host over TOR (clearnet is fine, but there is better and faster options).

## Usage

Add to the following step to your actions file in github.

The following executes "uname -a" on a remote host.

```
- uses: nolim1t/actions/torssh@0.2.0
  name: SSH Action
  env:
    PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
    USERHOST: ubuntu@sometorhost.onion
    CMD: uname -a
```

## Environment variables

* PRIVATE_KEY (This is the SSH private key. Recommended that this is a secret)
* USERHOST (The SSH host)
* CMD (The SSH command)

