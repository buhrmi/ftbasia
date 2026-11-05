<script>
  import NewsCardGrid from "~/components/NewsCardGrid.svelte";
  import PageMeta from "~/components/PageMeta.svelte";
  import SiteLayout from "~/layouts/SiteLayout.svelte";

  let { locale, locale_switches, news = [], meta } = $props();
</script>

<PageMeta {meta} />
<SiteLayout {locale} localeSwitches={locale_switches}>
  <main><NewsCardGrid {news} {locale} /></main>
</SiteLayout>
