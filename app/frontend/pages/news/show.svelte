<script>
  import { Link } from "inertiax-svelte";
  import { absoluteUrl, newsComponent, newsImage, formatNewsDate } from "~/news.js";
  import EntityTags from "~/shared/EntityTags.svelte";

  let { locale, slug, news, news_url, origin } = $props();

  const Content = $derived(newsComponent(locale, slug));
  const imageUrl = $derived(absoluteUrl(newsImage(slug, locale), origin));
</script>

<svelte:head>
  {#if imageUrl}
    <meta property="og:image" content={imageUrl} />
    <meta name="twitter:image" content={imageUrl} />
  {/if}
</svelte:head>

<nav class="mb-10">
  <Link href={news_url} class="text-sm text-neutral-400 hover:text-white">
    ← News
  </Link>
</nav>

{#if Content}
  <article class="news">
    <header class="news-header">
      <time
        datetime={news.published_at}
        class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase"
      >
        {formatNewsDate(news.published_at, locale)}
      </time>
      <h1>{news.title}</h1>
      <EntityTags tags={news.tags} {locale} />
    </header>
    <div class="news-content">
      <Content />
    </div>
  </article>
{/if}

<style>
  .news-header {
    margin-bottom: 1.5rem;
  }

  .news-header :global(h1) {
    margin-block: 0.5rem 0;
    font-size: 1.75rem;
    font-weight: 700;
    line-height: 1.3;
    letter-spacing: -0.01em;
  }

  .news-content :global(h1) {
    margin-block: 1rem 1.5rem;
    font-size: 1.75rem;
    font-weight: 700;
    line-height: 1.3;
    letter-spacing: -0.01em;
  }

  .news-header :global(.mt-6) {
    margin-top: 0.75rem;
  }

  .news-content {
    padding-top: 1.5rem;
  }

  .news-content :global(h2) {
    margin-block: 2.5rem 1rem;
    font-size: 1.375rem;
    font-weight: 600;
    line-height: 1.4;
  }

  .news-content :global(h3) {
    margin-block: 2rem 0.75rem;
    font-size: 1.0625rem;
    font-weight: 600;
    line-height: 1.5;
  }

  .news-content :global(p) {
    margin-block: 1rem;
    color: #d4d4d4;
    line-height: 1.9;
  }

  .news-content :global(strong) {
    color: white;
  }

  .news-content :global(a) {
    text-decoration: underline;
    text-underline-offset: 0.2em;
  }

  .news-content :global(ul),
  .news-content :global(ol) {
    margin-block: 1rem;
    padding-inline-start: 1.5rem;
    color: #d4d4d4;
    line-height: 1.9;
  }

  .news-content :global(ul) {
    list-style: disc;
  }

  .news-content :global(ol) {
    list-style: decimal;
  }

  .news-content :global(li) {
    margin-block: 0.5rem;
  }

  .news-content :global(blockquote) {
    margin-block: 2rem;
    border-inline-start: 2px solid #404040;
    padding-inline-start: 1.25rem;
    color: #a3a3a3;
  }

  .news-content :global(hr) {
    margin-block: 2.5rem;
    border: 0;
    border-top: 1px solid #262626;
  }

  .news-content :global(code) {
    border-radius: 0.25rem;
    background: #262626;
    padding: 0.15em 0.4em;
    font-size: 0.875em;
  }
</style>
