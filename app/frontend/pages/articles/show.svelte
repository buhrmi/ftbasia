<script>
  import { Link } from "inertiax-svelte";
  import { absoluteUrl, articleComponent, articleImage, formatArticleDate } from "~/articles.js";

  let { locale, slug, article, articles_url, origin } = $props();

  const Content = $derived(articleComponent(locale, slug));
  const imageUrl = $derived(absoluteUrl(articleImage(slug, locale), origin));
</script>

<svelte:head>
  {#if imageUrl}
    <meta property="og:image" content={imageUrl} />
    <meta name="twitter:image" content={imageUrl} />
  {/if}
</svelte:head>

<nav class="mb-10">
  <Link href={articles_url} class="text-sm text-neutral-400 hover:text-white">
    ← Articles
  </Link>
</nav>

{#if Content}
  <article class="article">
    <time
      datetime={article.published_at}
      class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase"
    >
      {formatArticleDate(article.published_at, locale)}
    </time>
    <Content />
  </article>
{/if}

<style>
  .article :global(h1) {
    margin-block: 1rem 1.5rem;
    font-size: 1.75rem;
    font-weight: 700;
    line-height: 1.3;
    letter-spacing: -0.01em;
  }

  .article :global(h2) {
    margin-block: 2.5rem 1rem;
    font-size: 1.375rem;
    font-weight: 600;
    line-height: 1.4;
  }

  .article :global(h3) {
    margin-block: 2rem 0.75rem;
    font-size: 1.0625rem;
    font-weight: 600;
    line-height: 1.5;
  }

  .article :global(p) {
    margin-block: 1rem;
    color: #d4d4d4;
    line-height: 1.9;
  }

  .article :global(strong) {
    color: white;
  }

  .article :global(a) {
    text-decoration: underline;
    text-underline-offset: 0.2em;
  }

  .article :global(ul),
  .article :global(ol) {
    margin-block: 1rem;
    padding-inline-start: 1.5rem;
    color: #d4d4d4;
    line-height: 1.9;
  }

  .article :global(ul) {
    list-style: disc;
  }

  .article :global(ol) {
    list-style: decimal;
  }

  .article :global(li) {
    margin-block: 0.5rem;
  }

  .article :global(blockquote) {
    margin-block: 2rem;
    border-inline-start: 2px solid #404040;
    padding-inline-start: 1.25rem;
    color: #a3a3a3;
  }

  .article :global(hr) {
    margin-block: 2.5rem;
    border: 0;
    border-top: 1px solid #262626;
  }

  .article :global(code) {
    border-radius: 0.25rem;
    background: #262626;
    padding: 0.15em 0.4em;
    font-size: 0.875em;
  }
</style>
