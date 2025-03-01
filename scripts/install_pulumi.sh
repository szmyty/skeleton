#!/usr/bin/env bash
# install_pulumi.sh - Installs Pulumi if not already installed.
# Author: Alan Szmyt

set -euo pipefail

PULUMI_HOME="${PULUMI_HOME:-${HOME}/.pulumi}"

install_pulumi() {
    if ! command -v pulumi &> /dev/null; then
        printf "Installing Pulumi...\n"
        curl --fail --silent --show-error --location https://get.pulumi.com | sh -s -- --install-root "${PULUMI_HOME}" --no-edit-path
    else
        printf "✅ Pulumi is already installed.\n"
    fi
}

verify_installation() {
    pulumi version
}

main() {
    trap 'printf "❌ An error occurred during execution.\n"' ERR
    install_pulumi
    verify_installation
}

main "$@"
