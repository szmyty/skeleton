#!/usr/bin/env bash
set -euo pipefail  # Exit on error, undefined variables, or failed pipes

echo "🔧 Installing Node.js via asdf..."

# Ensure asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "❌ asdf is not installed. Please install asdf first."
    exit 1
fi

# Add Node.js plugin if not already installed
if ! asdf plugin list | grep -q "^nodejs$"; then
    echo "📥 Adding asdf nodejs plugin..."
    asdf plugin add nodejs
fi

# Install Node.js from .tool-versions
echo "📦 Installing Node.js (version from .tool-versions)..."
asdf install nodejs

# Set global version from .tool-versions
asdf global nodejs "$(asdf latest nodejs)"

# Verify installation
echo "✅ Node.js installed successfully: $(node --version)"
