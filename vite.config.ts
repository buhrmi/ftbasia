import adapter from '@sveltejs/adapter-netlify'
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte'
import { sveltekit } from '@sveltejs/kit/vite'
import { defineConfig } from 'vite'
import { resolve } from 'node:path'
import { importAssets } from 'svelte-preprocess-import-assets'
import { mdsvex } from 'mdsvex'
import UnoCSS from 'unocss/vite'
import presetIcons from "@unocss/preset-icons"
import { presetWind4 } from 'unocss'
import { imagetools } from 'vite-imagetools'

export default defineConfig({
  plugins: [
    sveltekit({
      extensions: ['.svelte', '.md'],
      preprocess: [
        vitePreprocess(),
        mdsvex({ extensions: ['.md'] }),
        importAssets()
      ],
      adapter: adapter(),
      files: {
        assets: 'public',
        routes: 'src/routes',
        params: 'src/params.js'
      }
    }),
    UnoCSS({
      presets: [
        presetIcons({
          extraProperties: {
            display: "inline-block",
            "vertical-align": "middle"
          },
        }),
        presetWind4()
      ],
    }),
    imagetools()
  ],
  resolve: {
    alias: {
      '~': resolve('src')
    }
  }
})
