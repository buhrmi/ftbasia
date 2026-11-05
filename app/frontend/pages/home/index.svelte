<script>
  import EventCardGrid from "~/components/EventCardGrid.svelte";
  import NewsCardGrid from "~/components/NewsCardGrid.svelte";
  import PageMeta from "~/components/PageMeta.svelte";
  import SiteLayout from "~/layouts/SiteLayout.svelte";
  import { Link } from "@inertiajs/svelte";

  let { locale, locale_switches, events = [], news = [], meta } = $props();
  const japanese = $derived(locale === "ja");
  const genres = ["Drum & Bass", "Dubstep", "Trap", "Hardstyle"];
</script>

<PageMeta {meta} />
<SiteLayout {locale} localeSwitches={locale_switches}>
  <main class="home-page">
    <section class="home-hero" aria-labelledby="home-title">
      <h1 id="home-title" class="sr-only">Follow The Bass</h1>
      <img class="home-hero__logo" src="/logo.png" alt="" fetchpriority="high" />
      <p class="home-hero__tagline">
        Bass music culture in Tokyo and beyond.
      </p>
      <ul class="home-hero__genres" aria-label={japanese ? "ジャンル" : "Genres"}>
        {#each genres as genre (genre)}<li class="genre-badge genre-badge--{genre === "Drum & Bass" ? "dnb" : genre.toLowerCase()}">{genre}</li>{/each}
      </ul>
    </section>

    <section class="upcoming-events" aria-labelledby="upcoming-events-heading">
      <div class="upcoming-events__heading">
        <h2 id="upcoming-events-heading">{japanese ? "今後のイベント" : "Upcoming events"}</h2>
        <Link href={japanese ? "/events" : "/en/events"}>
          {japanese ? "イベント一覧" : "Event archive"} <span aria-hidden="true">↗</span>
        </Link>
      </div>
      {#if events.length}
        <div class="upcoming-events__list"><EventCardGrid {events} {locale} /></div>
      {:else}
        <div class="mt-5 rounded-lg border border-white/10 bg-white/[0.03] p-4 text-sm text-neutral-400">
          {japanese ? "次のイベントはまだ発表されていません。続報をお待ちください。" : "The next event is still under wraps. Stay tuned for the announcement."}
        </div>
      {/if}
    </section>

    <NewsCardGrid {news} {locale} compact />
  </main>
</SiteLayout>
