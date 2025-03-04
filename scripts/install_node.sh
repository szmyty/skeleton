#!/usr/bin/env bash
# install_node.sh - Installs Node.js using asdf version manager.
# Author: [Your Name]
# Date: [Today's Date]

set -euo pipefail  # Exit on error, undefined variables, or failed pipes

install_node() {
    printf "🔧 Installing Node.js via asdf...\n"

    # Ensure asdf is installed
    if ! command -v asdf &>/dev/null; then
        printf "❌ asdf is not installed. Please install asdf first.\n"
        exit 1
    fi

    # Check if Node.js is already installed
    if command -v node &>/dev/null; then
        printf "✅ Node.js is already installed: %s\n" "$(node --version)"
        return
    fi

    # Add Node.js plugin if not already installed
    if ! asdf plugin list | grep -q "^nodejs$"; then
        printf "📥 Adding asdf nodejs plugin...\n"
        asdf plugin add nodejs
    fi

    # Install Node.js from .tool-versions
    printf "📦 Installing Node.js (version from .tool-versions)...\n"
    asdf install nodejs

    # Set global version from .tool-versions
    asdf global nodejs "$(asdf latest nodejs)"
}

verify_installation() {
    if command -v node &>/dev/null; then
        printf "✅ Node.js installed successfully: %s\n" "$(node --version)"
    else
        printf "❌ Node.js installation failed.\n"
        exit 1
    fi
}

main() {
    trap 'printf "❌ An error occurred during execution.\n"' ERR
    install_node
    verify_installation
}

main "$@"
