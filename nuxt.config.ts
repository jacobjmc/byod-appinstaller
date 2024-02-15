// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  alias: {},
  devtools: {
    enabled: true,

    timeline: {
      enabled: true,
    },
  },
  vite: {
    // prevent vite from obscuring rust errors
    clearScreen: false,
    // Tauri expects a fixed port, fail if that port is not available
    server: {
      strictPort: true,
    },
    // to access the Tauri environment variables set by the CLI with information about the current target
    envPrefix: [
      "VITE_",
      "TAURI_PLATFORM",
      "TAURI_ARCH",
      "TAURI_FAMILY",
      "TAURI_PLATFORM_VERSION",
      "TAURI_PLATFORM_TYPE",
      "TAURI_DEBUG",
    ],
    build: {
      // Tauri uses Chromium on Windows and WebKit on macOS and Linux
      target:
        process.env.TAURI_PLATFORM == "windows" ? "chrome105" : "safari13",
      // don't minify for debug builds
      minify: !process.env.TAURI_DEBUG ? "esbuild" : false,
      // produce sourcemaps for debug builds
      sourcemap: !!process.env.TAURI_DEBUG,
    },
  },
  modules: ["@nuxt/ui"],
  tailwindcss: {
    exposeConfig: true,
  },
});
