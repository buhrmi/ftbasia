<script>
  import { Link } from "inertiax-svelte";
  import logo from "~/assets/logo.png";
  import { absoluteUrl, formatNewsDate } from "~/news.js";

  let { news, locale = "en", meta } = $props();

  const imageUrl = $derived(absoluteUrl(logo, meta.origin));
</script>

<svelte:head>
  {#if imageUrl}
    <meta property="og:image" content={imageUrl} />
    <meta name="twitter:image" content={imageUrl} />
  {/if}
</svelte:head>

<h1 class="mb-10 text-2xl font-semibold tracking-tight">News</h1>

{#if news.length}
  <ul class="space-y-8">
    {#each news as item (item.slug)}
      <li>
        <Link href={item.url} class="group block">
          <time
            datetime={item.published_at}
            class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase"
          >
            {formatNewsDate(item.published_at, locale)}
          </time>
          <h2 class="mt-2 text-lg font-semibold group-hover:underline">{item.title}</h2>
          {#if item.description}
            <p class="mt-2 text-sm leading-relaxed text-neutral-400">{item.description}</p>
          {/if}
        </Link>
      </li>
    {/each}
  </ul>
{:else}
  <p class="text-neutral-400">No news yet.</p>
{/if}

