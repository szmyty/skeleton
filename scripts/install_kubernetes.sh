#!/usr/bin/env bash

set -euo pipefail

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Normalize architecture names
case "$ARCH" in
    x86_64) ARCH="amd64" ;;
    aarch64 | arm64) ARCH="arm64" ;;
    *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

echo "🖥️ Detected OS: $OS, Architecture: $ARCH"

# Minikube Installation
if ! command -v minikube &> /dev/null; then
    echo "🔄 Installing Minikube..."
    curl --fail --silent --show-error --location \
        "https://storage.googleapis.com/minikube/releases/latest/minikube-${OS}-${ARCH}" \
        --output minikube
    chmod +x minikube
    mv minikube /usr/local/bin/minikube
    echo "✅ Minikube installed successfully!"
else
    echo "✅ Minikube is already installed."
fi

# Verify Minikube installation
minikube version

# kubectl Installation
if ! command -v kubectl &> /dev/null; then
    echo "🔄 Installing kubectl..."
    KUBECTL_VERSION=$(curl --fail --silent --show-error --location \
        "https://dl.k8s.io/release/stable.txt")
    curl --fail --silent --show-error --location \
        "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${OS}/${ARCH}/kubectl" \
        --output kubectl
    chmod +x kubectl
    mv kubectl /usr/local/bin/kubectl
    echo "✅ kubectl installed successfully!"
else
    echo "✅ kubectl is already installed."
fi

# Verify kubectl installation
kubectl version --client
