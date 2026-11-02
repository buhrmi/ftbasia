<script>
  import PageMeta from "~/shared/PageMeta.svelte";

  let { data } = $props();

  const japanese = $derived(data.locale === "ja");
</script>

<PageMeta meta={data.meta} />

<main class="partners-page">
  <p class="eyebrow">{japanese ? "会場オーナー・マネージャーの皆さまへ" : "For venue owners and managers"}</p>
  <h1>
    {japanese
      ? "あなたの会場で、Follow The Bassの夜を。"
      : "Bring a Follow The Bass night to your venue."}
  </h1>
  <p class="intro">
    {japanese
      ? "ベースミュージックのイベント開催にご興味のある会場の皆さま、ぜひご連絡ください。開催内容や日程について、一緒にお話ししましょう。"
      : "Interested in hosting a bass music event? We’d love to hear from venue owners and managers. Reach out to discuss the format, timing, and possibilities for your space."}
  </p>
  <a class="contact-button" href="https://zalo.me/0869344003" target="_blank" rel="noopener noreferrer">
    {japanese ? "Zaloでお問い合わせ" : "Contact us on Zalo"}
    <span aria-hidden="true">→</span>
  </a>
</main>

<style>
  .partners-page {
    max-width: 42rem;
    margin: 2rem auto 5rem;
    padding: 2rem 1.5rem 3rem;
    border: 1px solid rgb(255 255 255 / 10%);
    border-radius: 0.75rem;
    background: linear-gradient(135deg, rgb(255 255 255 / 4%), rgb(255 255 255 / 1%));
  }

  .eyebrow {
    margin: 0 0 1rem;
    color: #b8d978;
    font-size: 0.6875rem;
    font-weight: 600;
    letter-spacing: 0.14em;
    text-transform: uppercase;
  }

  h1 {
    margin: 0;
    font-size: clamp(2rem, 6vw, 3.25rem);
    font-weight: 600;
    letter-spacing: -0.04em;
    line-height: 1.1;
  }

  .intro {
    max-width: 34rem;
    margin: 1.25rem 0 1.75rem;
    color: #b3b3b3;
    font-size: 1rem;
    line-height: 1.75;
  }

  .contact-button {
    display: inline-flex;
    align-items: center;
    gap: 0.65rem;
    border-radius: 9999px;
    background: #d7f58c;
    padding: 0.85rem 1.25rem;
    color: #111;
    font-size: 0.875rem;
    font-weight: 700;
    text-decoration: none;
    transition: background-color 160ms ease, transform 160ms ease;
  }

  .contact-button:hover {
    transform: translateY(-1px);
    background: #e5ffab;
  }

  .contact-button:focus-visible {
    outline: 2px solid white;
    outline-offset: 4px;
  }

  @media (max-width: 560px) {
    .partners-page {
      margin-block: 1rem 3rem;
      padding: 1.5rem 1.25rem 2rem;
    }
  }
</style>
