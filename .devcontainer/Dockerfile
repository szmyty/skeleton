# Use a base image with common development tools (Ubuntu-based)
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Set non-interactive mode for package installations
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    tar \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Taskfile
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# Set up user workspace
WORKDIR /workspace

# Ensure the container stays running
CMD ["sleep", "infinity"]
