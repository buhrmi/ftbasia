<script>
  import "@unocss/reset/tailwind.css";
  import "virtual:uno.css";
  import "~/assets/global.css";
  import Default from "~/layouts/default.svelte";

  let { data, children } = $props();
</script>

<Default {data}>
  {@render children()}
</Default>
