<script>
  import DOMPurify from "dompurify";
  import { marked } from "marked";
  import EntityTags from "~/components/EntityTags.svelte";
  import PageMeta from "~/components/PageMeta.svelte";
  import SiteLayout from "~/layouts/SiteLayout.svelte";
  import { Link } from "@inertiajs/svelte";

  let { locale, locale_switches, news, meta } = $props();
  const japanese = $derived(locale === "ja");
  const articleHtml = $derived(DOMPurify.sanitize(marked.parse(news.body_markdown)));
  const eventFlyer = $derived(news.category === "event" ? news.tags.find((tag) => tag.type === "event")?.image : undefined);

  function displayDate(value) {
    return new Intl.DateTimeFormat(locale, { dateStyle: "long", timeZone: "UTC" }).format(new Date(value));
  }
</script>

<PageMeta {meta} />
<SiteLayout {locale} localeSwitches={locale_switches}>
  <main class="news-page py-8">
    {#if news.cover_image?.url}
      <div class="news-backdrop" aria-hidden="true"><img src={news.cover_image.url} alt="" /></div>
    {/if}
    <nav class="mb-10">
      <Link href={locale === "ja" ? "/news" : "/en/news"} class="text-sm text-neutral-400 hover:text-white">← {japanese ? "ニュース" : "News"}</Link>
    </nav>
    <article class="news">
      <header class="news-header">
        <time datetime={news.published_at} class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase">{displayDate(news.published_at)}</time>
        <h1>{news.title}</h1>
        <EntityTags tags={news.tags} {locale} />
      </header>
      {#if eventFlyer?.url}
        <figure class="news-photo">
          <img src={eventFlyer.url} alt={eventFlyer.alt_text ?? news.title} loading="lazy" />
          {#if eventFlyer.caption}<figcaption>{eventFlyer.caption}</figcaption>{/if}
        </figure>
      {:else if news.cover_image?.url}
        <figure class="news-photo">
          <img src={news.cover_image.url} alt={news.cover_image.alt_text ?? news.title} loading="lazy" />
          {#if news.slug === "follow-the-bass-launches-in-vietnam"}
            <figcaption><Link href={locale === "ja" ? "/artists/danangbassman" : "/en/artists/danangbassman"}>Stefan (@danangbassman)</Link></figcaption>
          {:else if news.cover_image.caption}
            <figcaption>{news.cover_image.caption}</figcaption>
          {/if}
        </figure>
      {/if}
      <div class="news-content">{@html articleHtml}</div>
      {#each news.embeds as embed (embed.url)}
        <iframe
          title={embed.title}
          src={embed.url}
          width="100%"
          height={embed.height}
          loading="lazy"
          class="news-embed rounded-lg"
          allow="autoplay; encrypted-media; picture-in-picture; web-share"
          referrerpolicy="strict-origin-when-cross-origin"
        ></iframe>
      {/each}
    </article>
  </main>
</SiteLayout>
