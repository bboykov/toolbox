#!/usr/bin/env bash
# TODO:
# - make it work with macos

# Strict Mode - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'


INSTALL_DIR="/usr/local/bin"

help() {
  cat <<EOF
Accepted cli arguments are:
  [--help|-h ] ->> prints this help
  [--version|-v <desired_version>] e.g. --version v1.17.0
EOF
}

download_binary(){
  curl -LO https://storage.googleapis.com/kubernetes-release/release/${DESIRED_VERSION}/bin/linux/amd64/kubectl
}

install_binary(){
  chmod +x ./kubectl
  mv ./kubectl "${INSTALL_DIR}/kubectl"
}

main() {

# Parsing input arguments (if any)
export INPUT_ARGUMENTS="${@}"

if [ $EUID -ne 0 ]; then
  echo "Run as root or use sudo"
  exit 1
fi

if [ $# -eq 0 ]; then
  help
  exit 1
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    '--version'|-v)
       shift
       if [[ $# -ne 0 ]]; then
           export DESIRED_VERSION="${1}"
       else
           echo -e "Please provide the desired version. e.g. --version v1.17.0"
           exit 0
       fi
       ;;
    '--help'|-h)
       help
       exit 0
       ;;
    *) exit 1
       ;;
  esac
  shift
done

download_binary
install_binary

}

main "$@"
