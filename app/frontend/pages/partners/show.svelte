<script>
  import PageMeta from "~/components/PageMeta.svelte";
  import SiteLayout from "~/layouts/SiteLayout.svelte";

  let { locale, locale_switches, meta } = $props();
  const japanese = $derived(locale === "ja");
</script>

<PageMeta {meta} />
<SiteLayout {locale} localeSwitches={locale_switches}>
  <main class="partners-page">
    <p class="content-index__eyebrow">{japanese ? "会場オーナー・マネージャーの皆さまへ" : "For venue owners and managers"}</p>
    <h1>{japanese ? "あなたの会場で、Follow The Bassの夜を。" : "Bring a Follow The Bass night to your venue."}</h1>
    <p class="intro">
      {japanese
        ? "ベースミュージックのイベント開催にご興味のある会場の皆さま、ぜひご連絡ください。開催内容や日程について、一緒にお話ししましょう。"
        : "Interested in hosting a bass music event? We’d love to hear from venue owners and managers. Reach out to discuss the format, timing, and possibilities for your space."}
    </p>
    <a class="contact-button" href="https://zalo.me/0869344003" target="_blank" rel="noopener noreferrer">
      {japanese ? "Zaloでお問い合わせ" : "Contact us on Zalo"} <span aria-hidden="true">→</span>
    </a>
  </main>
</SiteLayout>
