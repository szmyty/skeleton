import { defineConfig, loadEnv } from "vite";
import { resolve } from "path";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";
import tsconfigPaths from "vite-tsconfig-paths";
import fixReactVirtualized from "esbuild-plugin-react-virtualized";
import pkg from "./package.json";

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), "");

  return {
    define: {
      __PACKAGE_VERSION__: JSON.stringify(pkg.version),
      "process.env": env, // For legacy packages that rely on process.env.X
      global: "globalThis" // Fix for deck.gl/loaders.gl compatibility
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
      tailwindcss(),
      tsconfigPaths()
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
    }
  };
});
