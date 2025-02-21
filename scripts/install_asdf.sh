#!/usr/bin/env bash
set -euo pipefail

# Define versions and paths
ASDF_VERSION="v0.16.0"  # Set this to the latest stable version if needed
ASDF_INSTALL_DIR="/usr/local/bin"

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    ARCH="amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    ARCH="arm64"
else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

# Construct the download URL
ASDF_TARBALL="asdf-${OS}-${ARCH}.tar.gz"
ASDF_URL="https://github.com/asdf-vm/asdf/releases/download/${ASDF_VERSION}/${ASDF_TARBALL}"

# Download and install
echo "📥 Downloading asdf ${ASDF_VERSION} for ${OS}/${ARCH}..."
curl --fail --silent --show-error --location "$ASDF_URL" --output "/tmp/${ASDF_TARBALL}"

echo "📦 Extracting asdf..."
tar -xzf "/tmp/${ASDF_TARBALL}" -C "$ASDF_INSTALL_DIR"

# Ensure asdf is executable
chmod +x "${ASDF_INSTALL_DIR}/asdf"

# Clean up
rm -f "/tmp/${ASDF_TARBALL}"

# Verify installation
if command -v asdf &>/dev/null; then
    echo "✅ asdf installed successfully: $(asdf --version)"
else
    echo "❌ Failed to install asdf."
    exit 1
fi
