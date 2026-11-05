<script>
  import MediaGallery from "~/components/MediaGallery.svelte";
  import NewsList from "~/components/NewsList.svelte";
  import PageMeta from "~/components/PageMeta.svelte";
  import SiteLayout from "~/layouts/SiteLayout.svelte";

  let { locale, locale_switches, artist, news = [], meta } = $props();
  const japanese = $derived(locale === "ja");
</script>

<PageMeta {meta} />
<SiteLayout {locale} localeSwitches={locale_switches}>
  <main class="py-8">
    <MediaGallery items={artist.media} {locale} />
    <div class="flex items-center gap-5">
      {#if artist.avatar?.url}
        <img src={artist.avatar.url} alt={artist.avatar.alt_text ?? artist.name} class="h-24 w-24 shrink-0 rounded-full object-cover" />
      {/if}
      <div>
        <h1 class="text-2xl font-semibold tracking-tight">{artist.name}</h1>
        {#if artist.role}<p class="mt-2 text-sm text-neutral-300">{artist.role}</p>{/if}
        {#if artist.location}<p class="mt-1 text-sm text-neutral-500">{artist.location}</p>{/if}
      </div>
    </div>
    {#if artist.tagline}<p class="mt-4 text-sm text-neutral-500">{artist.tagline}</p>{/if}
    {#if artist.bio}<p class="mt-4 max-w-3xl whitespace-pre-line leading-relaxed text-neutral-300">{artist.bio}</p>{/if}
    {#if artist.links.length}
      <section class="mt-8">
        <h2 class="mb-3 text-sm font-semibold text-neutral-300">{japanese ? "公式リンク" : "Links"}</h2>
        <ul class="flex flex-wrap gap-x-5 gap-y-2 text-sm">
          {#each artist.links as link (link.url)}
            <li><a href={link.url} target="_blank" rel="noopener noreferrer" class="underline underline-offset-4">{link.label}</a></li>
          {/each}
        </ul>
      </section>
    {/if}
    {#if artist.sources.length}
      <section class="mt-8">
        <h2 class="mb-3 text-sm font-semibold text-neutral-300">{japanese ? "参考情報" : "Sources"}</h2>
        <ul class="space-y-2 text-sm text-neutral-400">
          {#each artist.sources as source (source.url)}
            <li><a href={source.url} target="_blank" rel="noopener noreferrer" class="underline underline-offset-4">{source.label}</a></li>
          {/each}
        </ul>
      </section>
    {/if}
    <NewsList {news} {locale} entityType="artist" />
  </main>
</SiteLayout>
