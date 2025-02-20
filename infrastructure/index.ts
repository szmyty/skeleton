import * as pulumi from "@pulumi/pulumi";
import * as k8s from "@pulumi/kubernetes";

// Define Kubernetes provider
const k8sProvider = new k8s.Provider("k8s-provider", {
    kubeconfig: "~/.kube/config",
    proxy: {
        httpProxy: "",
        httpsProxy: "",
        noProxy: "localhost,127.0.0.1",
    }
});

// Deploy Caddy container
const caddyDeployment = new k8s.apps.v1.Deployment("caddy", {
    metadata: { name: "caddy" },
    spec: {
        replicas: 1,
        selector: { matchLabels: { app: "caddy" } },
        template: {
            metadata: { labels: { app: "caddy" } },
            spec: {
                containers: [{
                    name: "caddy",
                    image: "caddy:latest",
                    ports: [{ containerPort: 80 }]
                }]
            }
        }
    }
}, { provider: k8sProvider });

// Expose Caddy as a service
const caddyService = new k8s.core.v1.Service("caddy-service", {
    metadata: { name: "caddy-service" },
    spec: {
        selector: { app: "caddy" },
        ports: [{ port: 80, targetPort: 80 }],
        type: "NodePort",
    }
}, { provider: k8sProvider });

// Deploy Kubernetes Dashboard
const dashboard = new k8s.helm.v3.Chart("kubernetes-dashboard", {
    chart: "kubernetes-dashboard",
    fetchOpts: { repo: "https://kubernetes.github.io/dashboard/" },
    values: {
        protocolHttp: true,
    }
}, { provider: k8sProvider });

// Expose Dashboard as a service
const dashboardService = new k8s.core.v1.Service("dashboard-service", {
    metadata: { name: "dashboard-service" },
    spec: {
        selector: { k8s-app: "kubernetes-dashboard" },
        ports: [{ port: 80, targetPort: 8443 }],
        type: "NodePort",
    }
}, { provider: k8sProvider });

export const caddyUrl = pulumi.interpolate`http://localhost:8080`;
export const dashboardUrl = pulumi.interpolate`http://localhost:8081`;
