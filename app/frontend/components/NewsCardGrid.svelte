<script>
  import { Link } from "@inertiajs/svelte";

  let { news = [], locale = "en", compact = false } = $props();
  const japanese = $derived(locale === "ja");

  function displayDate(value) {
    if (!value) return "";
    return new Intl.DateTimeFormat(locale, { dateStyle: "long", timeZone: "UTC" }).format(new Date(value));
  }
</script>

<section class:content-index--compact={compact} class="content-index content-index--news" aria-labelledby="news-index-heading">
  <header class="content-index__heading">
    {#if !compact}
      <p class="content-index__eyebrow">{japanese ? "Follow The Bass · ベースミュージック" : "Follow The Bass · Bass music"}</p>
    {/if}
    <svelte:element this={compact ? "h2" : "h1"} id="news-index-heading" class="content-index__title">
      {compact ? (japanese ? "最新ニュース" : "Latest news") : (japanese ? "ニュース" : "News")}
    </svelte:element>
    {#if !compact}
      <p class="content-index__intro">
        {japanese
          ? "Follow The Bassからのお知らせ、アーティスト、ベースミュージックのストーリー。"
          : "Announcements, artist stories and news from Follow The Bass."}
      </p>
    {/if}
  </header>
  {#if news.length}
    <ul class="content-index__grid">
      {#each news as item (item.slug)}
        <li class="content-index__card">
          <Link href={item.url} class="content-index__card-link">
            <div class="content-index__image">
              {#if item.cover_image?.url}
                <img src={item.cover_image.url} alt={item.cover_image.alt_text ?? ""} loading="lazy" />
              {:else}
                <div class="content-index__image-fallback" aria-hidden="true"></div>
              {/if}
            </div>
            <div class="content-index__card-content gap-3">
              <div class="news-card__meta">
                {#if item.category}<span class="news-card__category">{item.category}</span>{/if}
                <time class="news-card__date" datetime={item.published_at}>{displayDate(item.published_at)}</time>
              </div>
              <h2 class="content-index__card-title">{item.title}</h2>
              <span class="content-index__more">
                {japanese ? "記事を読む" : "Read story"} <span class="content-index__more-icon" aria-hidden="true">↗</span>
              </span>
            </div>
          </Link>
        </li>
      {/each}
    </ul>
  {:else}
    <p class="content-index__empty">{japanese ? "ニュースはまだありません。" : "No news yet."}</p>
  {/if}
</section>
