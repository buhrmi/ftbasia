<script>
  import Footer from "~/shared/Footer.svelte";
  import logo from "~/assets/logo.png";

  const {
    children,
    meta
  } = $props()

  const SITE_NAME = "Follow The Bass";

  const title = $derived(meta.title || "Bass music promotion in Tokyo and beyond since 2014");
  const description = $derived(meta.description);
</script>

<svelte:head>
  <title>{title}</title>
  {#if description}
    <meta name="description" content={description} />
  {/if}

  <meta property="og:site_name" content={SITE_NAME} />
  <meta property="og:title" content={title} />
  {#if description}
    <meta property="og:description" content={description} />
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
  <meta name="twitter:title" content={title} />
  {#if description}
    <meta name="twitter:description" content={description} />
  {/if}
</svelte:head>

<header class="site-header">
  <a
    class="site-header-link"
    href={meta.locale === "en" ? "/en/news" : "/news"}
    aria-label={`${SITE_NAME} news index`}
  >
    <div class="site-header-inner">
      <div class="flex items-center gap-4">
        <img src={logo} alt="" class="h-10 w-10 shrink-0 object-contain" />
        <p class="max-w-56 text-xs leading-relaxed text-neutral-400">
          Bass music promotion in Tokyo and beyond since 2014
        </p>
      </div>
    </div>
  </a>
</header>

{@render children()}

<Footer />

<style>
  .site-header {
    position: sticky;
    top: 0;
    z-index: 50;
    width: 100vw;
    margin-inline: calc(50% - 50vw);
    border-bottom: 1px solid rgb(255 255 255 / 10%);
    background: rgb(0 0 0 / 95%);
    backdrop-filter: blur(12px);
    margin-bottom: 12px;
  }

  .site-header-link {
    display: block;
    color: inherit;
    text-decoration: none;
  }

  .site-header-link:focus-visible {
    outline: 2px solid white;
    outline-offset: -2px;
  }

  .site-header-inner {
    display: flex;
    width: 100%;
    max-width: 48rem;
    margin-inline: auto;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    padding: 1.5rem;
  }
</style>