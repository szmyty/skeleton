#!/usr/bin/env bash
set -euo pipefail  # Exit on error, undefined variables, or failed pipes

# Define versions and paths
ASDF_VERSION="v0.16.4"  # Ensure this is the latest stable version
ASDF_BIN="/usr/local/bin/asdf"

# Detect OS and architecture
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"  # linux or darwin
ARCH="$(uname -m)"

# Map architecture names for correct binary
if [[ "$ARCH" == "x86_64" ]]; then
    ARCH="amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    ARCH="arm64"
else
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

# Construct the correct download URL
ASDF_TARBALL="asdf-${ASDF_VERSION}-${OS}-${ARCH}.tar.gz"
ASDF_URL="https://github.com/asdf-vm/asdf/releases/download/${ASDF_VERSION}/${ASDF_TARBALL}"

# Download and install
echo "📥 Downloading asdf ${ASDF_VERSION} for ${OS}/${ARCH} from ${ASDF_URL}..."
curl --fail --silent --show-error --location "$ASDF_URL" --output "/tmp/${ASDF_TARBALL}"

echo "📦 Extracting asdf..."
tar -xzf "/tmp/${ASDF_TARBALL}" -C /tmp

# Ensure extracted binary exists
if [[ ! -f "/tmp/asdf" ]]; then
    echo "❌ asdf binary not found in extracted files!"
    exit 1
fi

# Move binary to /usr/local/bin
echo "🚀 Installing asdf globally..."
install -m 755 "/tmp/asdf" "$ASDF_BIN"

# Clean up
rm -f "/tmp/${ASDF_TARBALL}" "/tmp/asdf"

# Verify installation
if command -v asdf &>/dev/null; then
    echo "✅ asdf installed successfully: $(asdf --version)"
else
    echo "❌ Failed to install asdf."
    exit 1
fi
