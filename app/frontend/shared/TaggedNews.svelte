<script>
  import { Link } from "inertiax-svelte";
  import { formatNewsDate } from "~/news.js";

  let { news, locale, entityType } = $props();

  const heading = $derived(
    locale === "ja"
      ? entityType === "artist"
        ? "このアーティストに関するニュース"
        : "このイベントに関するニュース"
      : entityType === "artist"
        ? "News featuring this artist"
        : "News featuring this event"
  );
  const emptyLabel = $derived(locale === "ja" ? "関連するニュースはありません。" : "No tagged news yet.");
</script>

<section class="mt-12">
  <h2 class="mb-6 text-lg font-semibold">{heading}</h2>
  {#if news.length}
    <ul class="space-y-6">
      {#each news as item (item.slug)}
        <li>
          <Link href={item.url} class="group block">
            <time
              datetime={item.published_at}
              class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase"
            >
              {formatNewsDate(item.published_at, locale)}
            </time>
            <h3 class="mt-2 font-semibold group-hover:underline">{item.title}</h3>
            {#if item.description}
              <p class="mt-2 text-sm leading-relaxed text-neutral-400">{item.description}</p>
            {/if}
          </Link>
        </li>
      {/each}
    </ul>
  {:else}
    <p class="text-sm text-neutral-400">{emptyLabel}</p>
  {/if}
</section>
