<script>
  import EventCardGrid from "~/components/EventCardGrid.svelte";
  import PageMeta from "~/components/PageMeta.svelte";
  import SiteLayout from "~/layouts/SiteLayout.svelte";

  let { locale, locale_switches, upcoming_events = [], past_events = [], meta } = $props();
  const japanese = $derived(locale === "ja");
</script>

<PageMeta {meta} />
<SiteLayout {locale} localeSwitches={locale_switches}>
  <main class="content-index">
    <header class="content-index__heading">
      <p class="content-index__eyebrow">{japanese ? "Follow The Bass · ベースミュージック" : "Follow The Bass · Bass music"}</p>
      <h1 class="content-index__title">{japanese ? "イベント" : "Events"}</h1>
    </header>
    {#if upcoming_events.length}
      <section class="mb-12">
        <h2 class="mb-5 text-xl font-semibold">{japanese ? "今後のイベント" : "Upcoming events"}</h2>
        <EventCardGrid events={upcoming_events} {locale} />
      </section>
    {/if}
    <section>
      <h2 class="mb-5 text-xl font-semibold">{japanese ? "過去のイベント" : "Past events"}</h2>
      {#if past_events.length}
        <EventCardGrid events={past_events} {locale} />
      {:else}
        <p class="text-neutral-400">{japanese ? "過去のイベントはありません。" : "No past events yet."}</p>
      {/if}
    </section>
  </main>
</SiteLayout>
