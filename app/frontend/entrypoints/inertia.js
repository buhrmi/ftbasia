import { createInertiaApp } from "@inertiajs/svelte";
import "@unocss/reset/tailwind.css";
import "virtual:uno.css";
import "@fontsource/montserrat/300.css";
import "../styles/application.css";

createInertiaApp({
  pages: "../pages",
  serverHead: true,
  defaults: {
    form: {
      forceIndicesArrayFormatInFormData: false,
      withAllErrors: true
    },
    visitOptions: () => ({ queryStringArrayFormat: "brackets" })
  }
});
