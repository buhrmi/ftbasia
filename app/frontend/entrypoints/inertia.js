import '@unocss/reset/tailwind.css'
import 'virtual:uno.css'
import 'tippy.js/dist/tippy.css'
import '~/assets/global.css'

import Default from "~/layouts/default.svelte"

import { createInertiaApp } from 'inertiax-svelte'

if (!import.meta.env.SSR) {
  await import('~/flash.js')
}

createInertiaApp({
  pages: "../pages",
  layout: () => Default,
  withApp(app, { ssr }) {
    if (ssr) return;
    import('~/setup.svelte.js');
  },
  // defaults: {
  //   visitOptions: (href, options) => {
  //     return { viewTransition: true };
  //   },
  // },
})
