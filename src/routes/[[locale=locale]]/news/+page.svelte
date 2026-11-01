<script>
  import PageMeta from "~/shared/PageMeta.svelte";
  import NewsIndex from "~/pages/news/index.svelte";

  let { data } = $props();
</script>

<PageMeta meta={data.meta} />
<NewsIndex news={data.news} locale={data.locale} meta={data.meta} />
