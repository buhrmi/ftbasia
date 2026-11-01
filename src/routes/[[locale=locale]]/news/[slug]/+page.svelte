<script>
  import PageMeta from "~/shared/PageMeta.svelte";
  import NewsShow from "~/pages/news/show.svelte";

  let { data } = $props();
</script>

<PageMeta meta={data.meta} />
<NewsShow
  locale={data.locale}
  slug={data.slug}
  news={data.news}
  news_url={data.news_url}
  meta={data.meta}
/>
