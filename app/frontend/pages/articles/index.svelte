<script>
  import { Link } from "inertiax-svelte";
  import logo from "~/assets/logo.png";
  import { absoluteUrl, formatArticleDate } from "~/articles.js";

  let { articles, locale = "en", origin } = $props();

  const imageUrl = $derived(absoluteUrl(logo, origin));
</script>

<svelte:head>
  {#if imageUrl}
    <meta property="og:image" content={imageUrl} />
    <meta name="twitter:image" content={imageUrl} />
  {/if}
</svelte:head>

<h1 class="mb-10 text-2xl font-semibold tracking-tight">Articles</h1>

{#if articles.length}
  <ul class="space-y-8">
    {#each articles as article (article.slug)}
      <li>
        <Link href={article.url} class="group block">
          <time
            datetime={article.published_at}
            class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase"
          >
            {formatArticleDate(article.published_at, locale)}
          </time>
          <h2 class="mt-2 text-lg font-semibold group-hover:underline">{article.title}</h2>
          {#if article.description}
            <p class="mt-2 text-sm leading-relaxed text-neutral-400">{article.description}</p>
          {/if}
        </Link>
      </li>
    {/each}
  </ul>
{:else}
  <p class="text-neutral-400">No articles yet.</p>
{/if}

