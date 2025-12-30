#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

INSTALL_DIR="/usr/local/bin"
DEFAULT_VERSION="v1.31.0"

help() {
  cat <<EOF
Install kubectl with optional version specification

Usage: $0 [options]

Options:
    --help, -h              Show this help message
    --version, -v <version> Install specific version (default: v1.31.0)
EOF
}

download_binary() {
  echo "Downloading kubectl ${DESIRED_VERSION}..."
  curl -LO "https://storage.googleapis.com/kubernetes-release/release/${DESIRED_VERSION}/bin/linux/amd64/kubectl"

  echo "Downloading checksum..."
  curl -LO "https://storage.googleapis.com/kubernetes-release/release/${DESIRED_VERSION}/bin/linux/amd64/kubectl.sha256"
}

verify_checksum() {
  echo "Verifying checksum..."
  if ! echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check; then
    echo "ERROR: Checksum verification failed!"
    echo "The downloaded kubectl binary does not match to expected checksum."
    rm -f kubectl kubectl.sha256
    exit 1
  fi

  echo "Checksum verification successful."
  rm -f kubectl.sha256
}

install_binary() {
  chmod +x ./kubectl
  mv ./kubectl "${INSTALL_DIR}/kubectl"
  echo "kubectl ${DESIRED_VERSION} installed successfully to ${INSTALL_DIR}/kubectl"
}

main() {
  # Parse command line arguments
  DESIRED_VERSION="$DEFAULT_VERSION"

  while [[ $# -gt 0 ]]; do
    case $1 in
    --version | -v)
      shift
      if [[ $# -ne 0 ]]; then
        DESIRED_VERSION="${1}"
      else
        echo "ERROR: Please provide a desired version. e.g. --version v1.17.0"
        exit 1
      fi
      ;;
    --help | -h)
      help
      exit 0
      ;;
    *)
      echo "ERROR: Unknown option $1"
      help
      exit 1
      ;;
    esac
    shift
  done

  download_binary
  verify_checksum
  install_binary
}

main "$@"
