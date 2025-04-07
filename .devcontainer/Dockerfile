# Use a base image with common development tools (Ubuntu-based)
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Proxy Environment Variables
# https://docs.docker.com/engine/reference/builder/#predefined-args
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY
ARG FTP_PROXY
ARG ALL_PROXY
ARG http_proxy
ARG https_proxy
ARG no_proxy
ARG ftp_proxy
ARG all_proxy

# Set non-interactive mode for package installations
ENV DEBIAN_FRONTEND=noninteractive

# Pulumi installation location
ENV PULUMI_HOME=/home/vscode/.pulumi

# Add Pulumi to the PATH
ENV PATH="${PULUMI_HOME}/bin:${PATH}"

# Set global environment variables for asdf
ENV ASDF_DATA_DIR=/home/vscode/.asdf
ENV ASDF_DIR="/usr/local/asdf"
ENV ASDF_SHIMS_DIR="${ASDF_DATA_DIR}/shims"

# Add asdf to the PATH
ENV PATH="${ASDF_DIR}/bin:${ASDF_SHIMS_DIR}:${PATH}"

# Install required dependencies
RUN apt-get update && apt-get install --yes --no-install-recommends \
    curl \
    git \
    unzip \
    tar \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Taskfile
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# Set up user workspace
WORKDIR /workspace

# Copy Taskfile into the container
COPY Taskfile.yml /workspace/Taskfile.yml

# Copy scripts directory into the container
COPY scripts/ /workspace/scripts/

# Ensure scripts are executable
RUN chmod +x /workspace/scripts/*

# Copy global Git configuration
COPY .gitconfig /etc/gitconfig

# Copy ASDF tool versions for consistent dependency management
COPY .tool-versions /workspace/.tool-versions

# Copy infrastructure directory
COPY infrastructure/ /workspace/infrastructure/

# Run Taskfile setup during build
RUN task setup

# Ensure Pulumi directory exists & is owned by the vscode user
RUN mkdir -p /home/vscode/.pulumi && chown --recursive vscode:vscode /home/vscode/.pulumi

EXPOSE 30080 30081

# Set the entrypoint
# ENTRYPOINT ["/workspace/scripts/entrypoint.sh"]

# Ensure the container stays running
CMD ["sleep", "infinity"]
