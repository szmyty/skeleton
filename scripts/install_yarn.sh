#!/usr/bin/env bash
set -euo pipefail  # Exit on error, undefined variables, or failed pipes

echo "🔧 Installing Yarn via asdf..."

# Ensure asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "❌ asdf is not installed. Please install asdf first."
    exit 1
fi

# Add Yarn plugin if not already installed
if ! asdf plugin list | grep -q "^yarn$"; then
    echo "📥 Adding asdf Yarn plugin..."
    asdf plugin add yarn
fi

# Install Yarn from .tool-versions (removes the need for "latest")
echo "📦 Installing Yarn (version from .tool-versions)..."
asdf install yarn

# Set global version from .tool-versions
asdf global yarn "$(asdf latest yarn)"

# Verify installation
echo "✅ Yarn installed successfully: $(yarn --version)"
