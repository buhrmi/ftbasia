<script>
  import PageMeta from "~/shared/PageMeta.svelte";
  import EventCardGrid from "~/shared/EventCardGrid.svelte";

  let { data } = $props();

  const title = $derived(data.locale === "ja" ? "過去のイベント" : "Past events");
</script>

<PageMeta meta={data.meta} />

<main class="events-index">
  <h1>{title}</h1>
  {#if data.events.length}
    <EventCardGrid events={data.events} locale={data.locale} />
  {:else}
    <p class="empty-state">
      {data.locale === "ja" ? "過去のイベントはありません。" : "No past events yet."}
    </p>
  {/if}
</main>

<style>
  .events-index h1 {
    margin: 0 0 1.5rem;
    font-size: 1.5rem;
    font-weight: 600;
    letter-spacing: -0.03em;
  }

  .empty-state {
    color: #a3a3a3;
  }
</style>
