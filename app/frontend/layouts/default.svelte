<script>
    import Footer from "~/shared/Footer.svelte";

  const {
    children
  } = $props()
</script>

<svelte:head>
  <title>Bass music shows in Tokyo and beyond</title>
</svelte:head>

{@render children()}

<Footer />