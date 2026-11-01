<script>
  import PageMeta from "~/shared/PageMeta.svelte";
  import ArtistShow from "~/pages/artists/show.svelte";

  let { data } = $props();
</script>

<PageMeta meta={data.meta} />
<ArtistShow profile={data.profile} news={data.news} locale={data.locale} />
