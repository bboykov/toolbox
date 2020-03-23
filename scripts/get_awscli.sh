#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

WORKDIR="/tmp"

if [ $EUID -ne 0 ]; then
  echo "Run as root or use sudo"
  exit 1
fi

cd "$WORKDIR"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install --update

rm awscliv2.zip
rm -rf ./aws/
