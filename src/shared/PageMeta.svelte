<script>
  const SITE_NAME = "Follow The Bass";

  let { meta } = $props();
</script>

<svelte:head>
  <title>{meta.title || "Bass music promotion in Tokyo and beyond since 2014"}</title>
  {#if meta.description}
    <meta name="description" content={meta.description} />
  {/if}
  <meta property="og:site_name" content={SITE_NAME} />
  <meta property="og:title" content={meta.title} />
  {#if meta.description}
    <meta property="og:description" content={meta.description} />
  {/if}
  <meta property="og:type" content={meta.og_type || "website"} />
  {#if meta.og_locale}
    <meta property="og:locale" content={meta.og_locale} />
  {/if}
  {#if meta.canonical_url}
    <meta property="og:url" content={meta.canonical_url} />
    <link rel="canonical" href={meta.canonical_url} />
  {/if}
  {#if meta.published_at}
    <meta property="article:published_time" content={meta.published_at} />
  {/if}
  <meta name="twitter:card" content="summary" />
  <meta name="twitter:title" content={meta.title} />
  {#if meta.description}
    <meta name="twitter:description" content={meta.description} />
  {/if}
</svelte:head>
