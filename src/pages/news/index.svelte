<script>
  import logo from "~/assets/logo.png";
  import { absoluteUrl, formatNewsDate, newsImage } from "~/news.js";

  let { news, locale = "en", meta, compact = false } = $props();

  const imageUrl = $derived(absoluteUrl(logo, meta.origin));
  const japanese = $derived(locale === "ja");
  const title = $derived(japanese ? "ニュース" : "News");
  const intro = $derived(
    japanese
      ? "Follow The Bassからのお知らせ、アーティスト、ベースミュージックのストーリー。"
      : "Announcements, artist stories and news from Follow The Bass."
  );
  const readLabel = $derived(japanese ? "記事を読む" : "Read story");
</script>

<svelte:head>
  {#if imageUrl}
    <meta property="og:image" content={imageUrl} />
    <meta name="twitter:image" content={imageUrl} />
  {/if}
</svelte:head>

<svelte:element
  this={compact ? "section" : "main"}
  class="content-index content-index--news"
  class:content-index--compact={compact}
  aria-labelledby="news-index-heading"
>
  <header class="content-index__heading">
    <p class="content-index__eyebrow">
      {japanese ? "Follow The Bass · ベースミュージック" : "Follow The Bass · Bass music"}
    </p>
    <svelte:element
      this={compact ? "h2" : "h1"}
      id="news-index-heading"
      class="content-index__title"
    >{title}</svelte:element>
    <p class="content-index__intro">{intro}</p>
  </header>

  {#if news.length}
    <ul class="content-index__grid">
      {#each news as item (item.slug)}
        {@const preview = newsImage(item.slug, locale)}
        <li class="content-index__card news-card">
          <a href={item.url} class="content-index__card-link">
            <div class="content-index__image">
              {#if preview}
                <img src={preview} alt="" loading="lazy" />
              {:else}
                <div class="content-index__image-fallback" aria-hidden="true"></div>
              {/if}
            </div>
            <div class="content-index__card-content">
              <div class="news-card__meta">
                {#if item.category}
                  <span class="news-card__category">{item.category}</span>
                {/if}
                <time
                  datetime={item.published_at}
                  class="news-card__date"
                >
                  {formatNewsDate(item.published_at, locale)}
                </time>
              </div>
              <h2 class="content-index__card-title">{item.title}</h2>
              <span class="content-index__more">
                {readLabel}
                <span class="content-index__more-icon" aria-hidden="true">↗</span>
              </span>
            </div>
          </a>
        </li>
      {/each}
    </ul>
  {:else}
    <p class="content-index__empty">
      {japanese ? "ニュースはまだありません。" : "No news yet."}
    </p>
  {/if}
</svelte:element>

<style>
  .news-card__meta {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 0.55rem 0.75rem;
  }

  .news-card__category {
    border: 1px solid rgb(201 239 106 / 35%);
    border-radius: 9999px;
    background: rgb(201 239 106 / 8%);
    padding: 0.25rem 0.55rem;
    color: #d7f58c;
    font-size: 0.625rem;
    font-weight: 600;
    letter-spacing: 0.12em;
    line-height: 1.25;
    text-transform: uppercase;
  }

  .news-card__date {
    color: #a3a3a3;
    font-size: 0.625rem;
    letter-spacing: 0.1em;
    line-height: 1.5;
    text-transform: uppercase;
  }

</style>
