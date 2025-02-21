#!/usr/bin/env bash
set -e
set -o pipefail

echo "🔧 Installing pnpm via asdf..."

# Ensure asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "❌ asdf is not installed. Please install asdf first."
    exit 1
fi

# Ensure pnpm is installed via asdf
if asdf list pnpm &>/dev/null; then
    echo "✅ pnpm is already installed via asdf."
else
    echo "📥 Installing pnpm..."
    asdf plugin add pnpm || true
    asdf install pnpm latest
    asdf global pnpm latest
    echo "✅ pnpm installation complete."
fi

# Verify installation
pnpm --version
echo "✅ pnpm setup finished."
