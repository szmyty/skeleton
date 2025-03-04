#!/usr/bin/env bash
# install_asdf.sh - Installs asdf version manager if not already installed.
# Author: Alan Szmyt

set -euo pipefail  # Exit on error, undefined variables, or failed pipes

ASDF_VERSION="v0.16.4"  # Ensure this is the latest stable version

detect_os_arch() {
    OS="$(uname -s | tr '[:upper:]' '[:lower:]')"  # linux or darwin
    ARCH="$(uname -m)"

    case "$ARCH" in
        x86_64) ARCH="amd64" ;;
        aarch64 | arm64) ARCH="arm64" ;;
        *)
            printf "❌ Unsupported architecture: %s\n" "$ARCH"
            exit 1
            ;;
    esac

    printf "🖥️ Detected OS: %s, Architecture: %s\n" "$OS" "$ARCH"
}

install_asdf() {
    if command -v asdf &>/dev/null; then
        printf "✅ asdf is already installed: %s\n" "$(asdf --version)"
        return
    fi

    local asdf_tarball="asdf-${ASDF_VERSION}-${OS}-${ARCH}.tar.gz"
    local asdf_url="https://github.com/asdf-vm/asdf/releases/download/${ASDF_VERSION}/${asdf_tarball}"

    printf "📥 Downloading asdf %s for %s/%s...\n" "$ASDF_VERSION" "$OS" "$ARCH"
    curl --fail --silent --show-error --location "$asdf_url" --output asdf.tar.gz

    printf "📦 Extracting asdf...\n"
    tar -xzf asdf.tar.gz

    if [[ ! -f "asdf" ]]; then
        printf "❌ asdf binary not found in extracted files!\n"
        exit 1
    fi

    printf "🚀 Installing asdf in /usr/local/bin/...\n"
    chmod +x asdf
    mv asdf /usr/local/bin/asdf

    # Clean up
    rm -f asdf.tar.gz

    printf "✅ asdf installed successfully!\n"
}

verify_installation() {
    if command -v asdf &>/dev/null; then
        printf "✅ asdf is available: %s\n" "$(asdf --version)"
    else
        printf "❌ Failed to install asdf.\n"
        exit 1
    fi
}

main() {
    trap 'printf "❌ An error occurred during execution.\n"' ERR
    detect_os_arch
    install_asdf
    verify_installation
}

main "$@"
