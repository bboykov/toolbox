#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

version="latest"

help() {
  cat <<EOF
Install Helm with optional version specification

Usage: $0 [options]

Options:
    --help, -h              Show this help message
    --version, -v <version> Install specific version (default: latest)
EOF
}

install_helm() {
  local version="${1:-latest}"

  local temp_dir
  temp_dir=$(mktemp -d)
  trap 'rm -rf "${temp_dir:-}"' EXIT

  cd "${temp_dir}"

  if [ "$version" = "latest" ]; then
    echo "Installing Helm (latest version)..."

    curl -fsSL "https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3" -o "get_helm.sh"
    chmod 700 get_helm.sh

    ./get_helm.sh
  else
    echo "Installing Helm version ${version}..."

    local helm_url="https://get.helm.sh/helm-${version}-linux-amd64.tar.gz"
    curl -fsSL "${helm_url}" -o "helm.tar.gz"

    tar -xzf helm.tar.gz
    chmod +x linux-amd64/helm
    mv linux-amd64/helm /usr/local/bin/helm
  fi

  echo "Helm installed successfully"
  helm version
}


while [[ $# -gt 0 ]]; do
  case $1 in
  --help | -h)
    help
    exit 0
    ;;
  --version | -v)
    shift
    if [[ $# -ne 0 ]]; then
      version="${1}"
    else
      echo "ERROR: Please provide a version. e.g. --version v3.14.0"
      exit 1
    fi
    ;;
  *)
    echo "ERROR: Unknown option $1"
    help
    exit 1
    ;;
  esac
  shift
done

install_helm "$version"
