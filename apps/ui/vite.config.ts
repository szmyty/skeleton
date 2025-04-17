import { defineConfig, loadEnv } from "vite";
import { resolve } from "path";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";
import fixReactVirtualized from "esbuild-plugin-react-virtualized";

// Optional: Inject version from package.json
import pkg from "./package.json";

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), "");

  return {
    define: {
      __PACKAGE_VERSION__: JSON.stringify(pkg.version),
      "process.env": env // if needed for legacy compat
    },
    optimizeDeps: {
      esbuildOptions: {
        plugins: [fixReactVirtualized],
      }
    },
    plugins: [
      react({
        jsxImportSource: "react",
        jsxRuntime: "automatic",
      }),
      tailwindcss()
    ],
    publicDir: "public",
    server: {
      port: 3000,
      host: true,
      strictPort: true,
      cors: true,
      headers: {
        "Access-Control-Allow-Origin": "*",
      },
    },
    resolve: {
      alias: {
        "@app": resolve(__dirname, "src/app"),
        "@components": resolve(__dirname, "src/components"),
        "@hooks": resolve(__dirname, "src/hooks"),
      }
    },
  };
});
