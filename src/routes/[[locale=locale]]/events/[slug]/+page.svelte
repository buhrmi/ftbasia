<script>
  import PageMeta from "~/shared/PageMeta.svelte";
  import EventShow from "~/pages/events/show.svelte";

  let { data } = $props();
</script>

<PageMeta meta={data.meta} />
<EventShow
  profile={data.profile}
  news={data.news}
  shows={data.shows}
  locale={data.locale}
/>
