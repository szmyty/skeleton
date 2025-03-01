import * as pulumi from "@pulumi/pulumi";
import * as k8s from "@pulumi/kubernetes";

// Define Kubernetes provider with an explicit version
const k8sProvider = new k8s.Provider("k8s-provider", {
  kubeconfig: "~/.kube/config",
  enableServerSideApply: true,  // Helps with declarative updates
  suppressDeprecationWarnings: true, // Avoid warnings on minor version mismatches
});

// Create a Namespace for better organization
const appNamespace = new k8s.core.v1.Namespace("app-namespace", {}, { provider: k8sProvider });

// 🚀 **Deploy Caddy**
const caddyDeployment = new k8s.apps.v1.Deployment("caddy", {
    metadata: { name: "caddy", namespace: appNamespace.metadata.name },
    spec: {
        replicas: 1,
        selector: { matchLabels: { app: "caddy" } },
        template: {
            metadata: { labels: { app: "caddy" } },
            spec: {
                containers: [{
                    name: "caddy",
                    image: "caddy:2.7.4",
                    ports: [{ containerPort: 30080, hostPort: 30080 }]
                }]
            }
        }
    }
}, { provider: k8sProvider });

// 🌐 **Expose Caddy via NodePort**
const caddyService = new k8s.core.v1.Service("caddy-service", {
    metadata: { name: "caddy-service", namespace: appNamespace.metadata.name },
    spec: {
        selector: { app: "caddy" },
        ports: [{ port: 30080, targetPort: 30080, nodePort: 30080 }],
        type: "NodePort"
    }
}, { provider: k8sProvider });

// 📊 **Deploy Kubernetes Dashboard**
const dashboard = new k8s.helm.v3.Chart("kubernetes-dashboard", {
    chart: "kubernetes-dashboard",
    fetchOpts: { repo: "https://kubernetes.github.io/dashboard/" },
    values: {
        protocolHttp: true,
    }
}, { provider: k8sProvider });

// 🌐 **Expose Dashboard via NodePort**
const dashboardService = new k8s.core.v1.Service("dashboard-service", {
    metadata: { name: "dashboard-service", namespace: appNamespace.metadata.name },
    spec: {
        selector: { "k8s-app": "kubernetes-dashboard" },
        ports: [{ port: 30081, targetPort: 8443, nodePort: 30081 }],
        type: "NodePort"
    }
}, { provider: k8sProvider });

// Export URLs for easy access
// export const caddyUrl = pulumi.interpolate`http://localhost:30080`;
// export const dashboardUrl = pulumi.interpolate`http://localhost:30081`;

export const caddyUrl = pulumi.interpolate`http://0.0.0.0:30080`;
export const dashboardUrl = pulumi.interpolate`http://0.0.0.0:30081`;
