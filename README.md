# toolbox

![Docker](https://github.com/bboykov/toolbox/workflows/Docker/badge.svg)

## Design Philosophy

This container runs as root because troubleshooting often requires network packet capture, filesystem access, and system-level tools.

Tools are installed on-demand to keep the base image small. This reduces attack surface while maintaining flexibility.

## Usage

### Docker Usage

**Host mode** (--net=host, --pid=host, --ipc=host): Provides access to host network and process namespace. Container has host-level visibility.

**Volume mounting**: Mounting `/:/workdir` gives full host filesystem access. Consider mounting specific directories for better isolation.

```sh
# Run locally (WARNING: mounts entire host filesystem - use with caution)
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

### Tools on Demand

Installation scripts support version selection. Run scripts without arguments to see latest installed versions.

```sh
# Helm (latest by default, specify version with --version)
get_helm.sh --version v3.1.0

# AWS CLI v2 (single version available)
get_awscli.sh

# kubectl (check script for latest available)
get_kubectl.sh --version v1.31.0
```

## Local Development

Use the included Makefile for common tasks:

```sh
make help    # View all available targets
make build   # Build Docker image
make check   # Run pre-commit hooks manually
```

The repository uses `.editorconfig` for consistent coding styles. Most editors auto-apply these settings.

## Security

All images are scanned with Trivy before pushing to Docker Hub. Known third-party vulnerabilities are documented in `.trivyignore`.

This container runs as root - use only in trusted environments.

## Development

### Pre-commit Hooks

Install pre-commit to run automatic checks before committing:

```sh
pip install pre-commit
pre-commit install
```

Run checks on all files:

```sh
pre-commit run --all-files
```

The pre-commit hooks will:
- Check for tabs (forbidden except in Makefiles)
- Validate shell scripts with ShellCheck
- Check YAML syntax
- Fix trailing whitespace and missing newlines at EOF
