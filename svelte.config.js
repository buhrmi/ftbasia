import { vitePreprocess } from '@sveltejs/vite-plugin-svelte'
import { importAssets } from 'svelte-preprocess-import-assets'
import { compile } from 'svelte/compiler'
import { mdsvex } from 'mdsvex'

export default {
  // Consult https://svelte.dev/docs#compile-time-svelte-preprocess
  // for more information about preprocessors
  extensions: ['.svelte', '.md'],
  preprocess: [
    vitePreprocess(),
    mdsvex({ extensions: ['.md'] }),
    importAssets()
  ],
	compilerOptions: {
		experimental: {
			async: true
		}
	}
}
