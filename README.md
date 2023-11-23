# toolbox

![Docker](https://github.com/bboykov/toolbox/workflows/Docker/badge.svg)

## Usage

```sh
# Run locally
docker run -it --rm --name toolbox \
  -v /:/workdir \
  --ipc=host \
  --net=host \
  --pid=host \
  bboykov/toolbox:latest

# Run as pod in K8S
kubectl run -i --tty --rm toolbox \
  --image=bboykov/toolbox:latest \
  --restart=Never -- bash
```

## Tools on demand

```sh
# Helm
get_helm.sh --version v3.1.0

# awscli
get_awscli.sh

# kubectl
get_kubectl.sh --version v1.17.0
```
