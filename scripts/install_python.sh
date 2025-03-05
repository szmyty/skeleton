#!/usr/bin/env bash
set -euo pipefail  # Exit on error, undefined variables, or failed pipes

echo "🔧 Installing Python via asdf..."

# Ensure asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "❌ asdf is not installed. Please install asdf first."
    exit 1
fi

# Add Python plugin if not already installed
if ! asdf plugin list | grep -q "^python$"; then
    echo "📥 Adding asdf Python plugin..."
    asdf plugin add python
fi

# Install Python from .tool-versions (removes the need for "latest")
echo "📦 Installing Python (version from .tool-versions)..."
asdf install python

# Set global version from .tool-versions
asdf global python "$(asdf latest python)"

# Verify installation
echo "✅ Python installed successfully: $(python --version)"
