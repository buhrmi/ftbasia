import { svelte } from "@sveltejs/vite-plugin-svelte";
import inertia from "@inertiajs/vite";
import { defineConfig } from "vite";
import { resolve } from "node:path";
import RubyPlugin from "vite-plugin-ruby";
import UnoCSS from "unocss/vite";
import presetIcons from "@unocss/preset-icons";
import { presetWind4 } from "unocss";

export default defineConfig({
  plugins: [
    RubyPlugin(),
    inertia(),
    svelte(),
    UnoCSS({
      presets: [
        presetIcons({
          extraProperties: {
            display: "inline-block",
            "vertical-align": "middle"
          }
        }),
        presetWind4()
      ]
    })
  ],
  resolve: {
    alias: {
      "~": resolve("app/frontend")
    }
  }
});
