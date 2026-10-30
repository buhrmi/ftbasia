<script>
  import Footer from "~/shared/Footer.svelte";
  import logo from "~/assets/logo.png";
  import { page } from "inertiax-svelte";

  const {
    children
  } = $props()

  const SITE_NAME = "Follow The Bass";
  const ARTISTS_URL = "https://followthebass.asia/artists";

  const meta = $derived(page.props);
  const title = $derived(meta.title || "Bass music promotion in Tokyo and beyond since 2014");
  const description = $derived(meta.description);
  const artistsLabel = $derived(meta.locale === "ja" ? "アーティストの方へ" : "For artists");
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

<header class="mb-10 flex flex-wrap items-center justify-between gap-4 border-b border-white/10 py-6">
  <div class="flex items-center gap-4">
    <img src={logo} alt={SITE_NAME} class="h-10 w-10 shrink-0 object-contain" />
    <p class="max-w-56 text-xs leading-relaxed text-neutral-400">
      Bass music promotion in Tokyo and beyond since 2014
    </p>
  </div>
  <a
    href={ARTISTS_URL}
    target="_blank"
    rel="noreferrer"
    class="inline-flex items-center rounded-full border border-white/20 px-4 py-2 text-xs text-neutral-300 transition-colors hover:border-white/40 hover:text-white"
  >
    {artistsLabel}
  </a>
</header>

{@render children()}

<Footer />