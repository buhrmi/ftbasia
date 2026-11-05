<script>
  import EntityTags from "~/components/EntityTags.svelte";
  import EventDetails from "~/components/EventDetails.svelte";
  import NewsList from "~/components/NewsList.svelte";
  import PageMeta from "~/components/PageMeta.svelte";
  import SiteLayout from "~/layouts/SiteLayout.svelte";
  import { Link } from "@inertiajs/svelte";

  let { locale, locale_switches, event, news = [], meta } = $props();
</script>

<PageMeta {meta} />
<SiteLayout {locale} localeSwitches={locale_switches}>
  <main class="py-8">
    <nav class="mb-8"><Link href={locale === "ja" ? "/events" : "/en/events"} class="text-sm text-neutral-400 hover:text-white">← {locale === "ja" ? "イベント一覧" : "Events"}</Link></nav>
    <header>
      <h1 class="text-3xl font-semibold tracking-tight">{event.name}</h1>
      {#if event.bio}<p class="mt-4 max-w-3xl leading-relaxed text-neutral-300">{event.bio}</p>{/if}
      <EntityTags tags={[...event.artist_tags, ...event.promoter_tags]} {locale} />
    </header>
    <EventDetails {event} {locale} />
    <NewsList {news} {locale} entityType="event" />
  </main>
</SiteLayout>
