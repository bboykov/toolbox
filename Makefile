# Makefile for toolbox Docker container

.PHONY: help build run shell exec mount clean check

# Default target
help:
	@echo "Toolbox Docker Container"
	@echo ""
	@echo "Available targets:"
	@echo "  build    - Build Docker image"
	@echo "  run      - Run the container in interactive mode"
	@echo "  shell    - Run container with bash shell (interactive)"
	@echo "  exec     - Run container with bash shell (non-interactive)"
	@echo "  mount    - Run container with volume mount to current directory"
	@echo "  check    - Run pre-commit hooks on all files"
	@echo "  clean    - Remove Docker image"
	@echo "  help     - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make build"
	@echo "  make run"
	@echo "  make mount"
	@echo "  make check"

# Build the Docker image
build:
	@echo "Building toolbox Docker image..."
	docker build -t bboykov/toolbox:latest .
	@echo "Build complete!"

# Run container in interactive mode
run: build
	@echo "Running toolbox container..."
	docker run -it --rm \
		--name toolbox \
		bboykov/toolbox:latest

# Run container with bash shell (interactive)
shell: build
	@echo "Starting toolbox with bash shell..."
	docker run -it --rm \
		--name toolbox \
		bboykov/toolbox:latest \
		bash

# Run container with bash shell (non-interactive)
exec: build
	@echo "Starting toolbox (non-interactive)..."
	docker run --rm \
		--name toolbox \
		bboykov/toolbox:latest \
		bash

# Run container with volume mount to current directory
mount: build
	@echo "Starting toolbox with volume mount..."
	docker run -it --rm \
		--name toolbox \
		-v "$(PWD):/workdir" \
		bboykov/toolbox:latest \
		bash

# Remove the Docker image
clean:
	@echo "Removing toolbox Docker image..."
	docker rmi bboykov/toolbox:latest 2>/dev/null || true
	@echo "Cleanup complete!"

# Run pre-commit hooks on all files
check:
	@echo "Running pre-commit hooks..."
	pre-commit run --all-files

# Build and run in one command
build-run: build run
