#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

install_aws_cli() {
  echo "Installing AWS CLI..."

  local temp_dir
  temp_dir=$(mktemp -d)
  trap 'rm -rf "${temp_dir:-}"' EXIT

  cd "${temp_dir}"
  curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

  unzip -q awscliv2.zip
  ./aws/install

  echo "AWS CLI installed successfully"
  aws --version
}

install_aws_cli "$@"
