#!/bin/bash
set -e  # Exit on any error

PULUMI_HOME="${PULUMI_HOME:-$HOME/.pulumi}"

# Check if Pulumi is already installed
if ! command -v pulumi &> /dev/null; then
    echo "Installing Pulumi..."
    curl --fail --silent --show-error --location https://get.pulumi.com | sh -s -- --install-root "${PULUMI_HOME}" --no-edit-path
else
    echo "✅ Pulumi is already installed."
fi

# Print version to verify installation
pulumi version
