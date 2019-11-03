# SCP over TOR

## About

This github action copies a provided folder and destination over TOR, so you can use .onion hosts for deployment

## Environment variables

* PRIVATE_KEY (This is the SSH private key. Recommended that this is a secret)
* SRC (This is the folder to deploy)
* DEST (This is the destination folder to copy over. In the form of user@host:/path/to/folder)

## Example Action YML

This is used to deploy nolim1t.co to its TOR site.

```yaml
name: Auto Deploy

on: [push]


jobs:
  build:

    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@master
        name: Checkout master
      - name: Checkout submodules
        uses: textbook/git-checkout-submodule-action@1.0.0
      - uses: actions/setup-ruby@v1
        name: Run rakefile with ruby
        with:
          ruby-version: '2.x' # Version range or exact version of a Ruby version to use, using semvers version range syntax.
      - run: rake
        env:
          GITHUB: true
        name: Run Rakefile
      - uses: nolim1t/actions/torscp@0.1.1
        name: Deploy to TOR over SCP
        env:
          SRC: _site
          DEST: ${{ secrets.DEST }}
          PRIVATE_KEY: ${{ secrets.PRIVATE_KEY }}
```
