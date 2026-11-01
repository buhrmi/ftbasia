<script>
  let { error, status } = $props();
</script>

<svelte:head>
  <title>{status} — Follow The Bass</title>
</svelte:head>

<main class="py-16 text-center">
  <p class="text-sm tracking-[0.25em] text-neutral-500 uppercase">{status}</p>
  <h1 class="mt-4 text-2xl font-semibold">Page not found</h1>
  <p class="mt-3 text-sm text-neutral-400">{error?.message ?? "The page could not be found."}</p>
  <a href="/news" class="mt-6 inline-block text-sm underline underline-offset-4">News</a>
</main>
