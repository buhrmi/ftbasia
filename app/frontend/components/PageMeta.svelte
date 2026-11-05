<script>
  let { meta } = $props();
</script>

<svelte:head>
  <title>{meta?.title ?? "Follow The Bass"}</title>
  {#if meta?.description}
    <meta name="description" content={meta.description} />
    <meta property="og:description" content={meta.description} />
    <meta name="twitter:description" content={meta.description} />
  {/if}
  <meta property="og:site_name" content="Follow The Bass" />
  <meta property="og:title" content={meta?.title ?? "Follow The Bass"} />
  <meta property="og:type" content={meta?.published_at ? "article" : "website"} />
  {#if meta?.canonical_url}
    <meta property="og:url" content={meta.canonical_url} />
    <link rel="canonical" href={meta.canonical_url} />
  {/if}
  {#if meta?.image_url}
    <meta property="og:image" content={meta.image_url} />
    <meta name="twitter:image" content={meta.image_url} />
  {/if}
  {#if meta?.published_at}
    <meta property="article:published_time" content={meta.published_at} />
  {/if}
  <meta name="twitter:card" content="summary_large_image" />
</svelte:head>
