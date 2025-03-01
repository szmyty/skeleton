#!/usr/bin/env bash
# install_kubernetes.sh - Installs Minikube and kubectl if not already installed.
# Author: Alan Szmyt

set -euo pipefail

detect_os_arch() {
    OS=$(uname -s | tr '[:upper:]' '[:lower:]')
    ARCH=$(uname -m)

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

install_minikube() {
    if ! command -v minikube &> /dev/null; then
        printf "🔄 Installing Minikube...\n"
        curl --fail --silent --show-error --location \
            "https://storage.googleapis.com/minikube/releases/latest/minikube-${OS}-${ARCH}" \
            --output minikube
        chmod +x minikube
        mv minikube /usr/local/bin/minikube
        printf "✅ Minikube installed successfully!\n"
    else
        printf "✅ Minikube is already installed.\n"
    fi
}

verify_minikube() {
    minikube version
}

install_kubectl() {
    if ! command -v kubectl &> /dev/null; then
        printf "🔄 Installing kubectl...\n"
        KUBECTL_VERSION=$(curl --fail --silent --show-error --location \
            "https://dl.k8s.io/release/stable.txt")
        curl --fail --silent --show-error --location \
            "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${OS}/${ARCH}/kubectl" \
            --output kubectl
        chmod +x kubectl
        mv kubectl /usr/local/bin/kubectl
        printf "✅ kubectl installed successfully!\n"
    else
        printf "✅ kubectl is already installed.\n"
    fi
}

verify_kubectl() {
    kubectl version --client
}

main() {
    trap 'printf "❌ An error occurred during execution.\n"' ERR
    detect_os_arch
    install_minikube
    verify_minikube
    install_kubectl
    verify_kubectl
}

main "$@"
