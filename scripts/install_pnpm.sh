#!/usr/bin/env bash
set -euo pipefail  # Exit on error, undefined variables, or failed pipes

echo "🔧 Installing pnpm via asdf..."

# Ensure asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "❌ asdf is not installed. Please install asdf first."
    exit 1
fi

# Add pnpm plugin if not already installed
if ! asdf plugin list | grep -q "^pnpm$"; then
    echo "📥 Adding asdf pnpm plugin..."
    asdf plugin add pnpm
fi

# Install pnpm from .tool-versions (removes the need for "latest")
echo "📦 Installing pnpm (version from .tool-versions)..."
asdf install pnpm

# Set global version from .tool-versions
asdf global pnpm "$(asdf latest pnpm)"

# Verify installation
echo "✅ pnpm installed successfully: $(pnpm --version)"
