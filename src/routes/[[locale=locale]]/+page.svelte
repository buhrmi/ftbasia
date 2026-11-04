<script>
  import "@fontsource/montserrat/300.css";
  import "@fontsource/montserrat/700.css";
  import heroImage from "~/content/artists/danangbassman.jpg";
  import NewsIndex from "~/pages/news/index.svelte";
  import PageMeta from "~/shared/PageMeta.svelte";

  let { data } = $props();

  const japanese = $derived(data.locale === "ja");
  const localePrefix = $derived(japanese ? "" : "/en");
  const genres = ["Drum & Bass", "Dubstep", "Trap", "Hardstyle"];
</script>

<PageMeta meta={data.meta} />

<main class="home-page">
  <section class="home-hero" class:home-hero--ja={japanese} aria-labelledby="home-tagline">
    <div class="home-hero__image" aria-hidden="true">
      <img src={heroImage} alt="" fetchpriority="high" />
    </div>
    <div class="home-hero__content">
      <p class="home-hero__eyebrow">
        <span class="home-hero__signal" aria-hidden="true"></span>
        {japanese ? "ベースミュージックのニュースとカルチャー" : "Bass music news & culture"}
        <span class="home-hero__since">{japanese ? "東京 · ダナン" : "Tokyo · Da Nang"}</span>
      </p>
      <h1 id="home-tagline">
        {#if japanese}
          <span>東京から、</span>
          <em>ベースのその先へ。</em>
        {:else}
          <span>Tokyo roots.</span>
          <em>Bass beyond.</em>
        {/if}
      </h1>
      <p class="home-hero__intro">
        {japanese
          ? "2014年から、東京・ダナンをはじめ各地のベースミュージックニュースとアーティスト情報を発信。"
          : "Bass music news and artist features since 2014. From Tokyo to Da Nang, and beyond."}
      </p>
      <div class="home-hero__actions">
        <a class="home-hero__primary" href={`${localePrefix}/artists`}>
          {japanese ? "注目アーティスト" : "Featured artists"}
          <span aria-hidden="true">↗</span>
        </a>
        <a class="home-hero__secondary" href={`${localePrefix}/news`}>
          {japanese ? "最新ニュース" : "Latest stories"}
          <span aria-hidden="true">→</span>
        </a>
      </div>
    </div>
    <p class="home-hero__caption">
      <span>MY KHE BEACH</span>
      <span>DA NANG, VIETNAM</span>
    </p>
    <span class="home-hero__index" aria-hidden="true">EST. 2014</span>
  </section>

  <section class="home-genres" aria-label={japanese ? "ジャンル" : "Genres"}>
    <div class="home-genres__inner">
      <p>{japanese ? "取り上げるジャンル" : "GENRES COVERED"}</p>
      <ul>
        {#each genres as genre (genre)}
          <li>{genre}</li>
        {/each}
      </ul>
    </div>
  </section>

  <section class="upcoming-events" aria-labelledby="upcoming-events-heading">
    <div class="upcoming-events__heading">
      <div>
        <p class="home-section__eyebrow">{japanese ? "次のベースライン" : "THE NEXT BASELINE"}</p>
        <h2 id="upcoming-events-heading">{japanese ? "今後のイベント" : "Upcoming events"}</h2>
      </div>
      <a href={`${localePrefix}/events`}>
        {japanese ? "過去のイベント" : "Event archive"}
        <span aria-hidden="true">↗</span>
      </a>
    </div>
    <div class="upcoming-events__empty">
      <span class="upcoming-events__signal" aria-hidden="true"></span>
      <p>
        {japanese
          ? "次のイベントはまだ発表されていません。続報をお待ちください。"
          : "The next event is still under wraps. Stay tuned for the announcement."}
      </p>
    </div>
  </section>

  <section class="venue-cta" aria-labelledby="venue-cta-heading">
    <div>
      <p>{japanese ? "会場オーナー・マネージャーの皆さまへ" : "FOR VENUE OWNERS & MANAGERS"}</p>
      <h2 id="venue-cta-heading">
        {japanese
          ? "Follow The Bassのイベントを開催しませんか？"
          : "Bring a Follow The Bass night to your venue."}
      </h2>
    </div>
    <a href={`${localePrefix}/partners`}>
      {japanese ? "パートナーについて" : "Explore partnerships"}
      <span aria-hidden="true">↗</span>
    </a>
  </section>

  <NewsIndex news={data.news} locale={data.locale} meta={data.meta} compact />
</main>

<style>
  .home-hero {
    position: relative;
    display: flex;
    width: 100vw;
    min-height: min(48rem, max(37rem, calc(100svh - 5.25rem)));
    align-items: flex-end;
    overflow: hidden;
    margin-inline: calc(50% - 50vw);
    background: #080909;
    isolation: isolate;
  }

  .home-hero__image,
  .home-hero__image::after {
    position: absolute;
    inset: 0;
  }

  .home-hero__image {
    z-index: -2;
  }

  .home-hero__image::after {
    background:
      linear-gradient(90deg, rgb(5 7 9 / 94%) 0%, rgb(5 7 9 / 78%) 34%, rgb(5 7 9 / 12%) 100%),
      linear-gradient(0deg, #080909 0%, rgb(8 9 9 / 65%) 16%, transparent 58%),
      linear-gradient(180deg, rgb(8 9 9 / 38%), transparent 26%);
    content: "";
  }

  .home-hero__image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center 54%;
    filter: brightness(0.82) saturate(0.82);
  }

  .home-hero::before {
    position: absolute;
    z-index: -1;
    inset: 0;
    background: radial-gradient(ellipse at 73% 50%, rgb(201 239 106 / 12%), transparent 40%);
    content: "";
    pointer-events: none;
  }

  .home-hero__content {
    width: min(76rem, calc(100% - 3rem));
    margin: 0 auto;
    padding-block: 7rem 7.5rem;
  }

  .home-hero__eyebrow {
    display: flex;
    align-items: center;
    gap: 0.65rem;
    margin: 0 0 1.5rem;
    color: #e5e5e5;
    font-size: 0.68rem;
    font-weight: 600;
    letter-spacing: 0.15em;
    text-transform: uppercase;
  }

  .home-hero__signal,
  .upcoming-events__signal {
    width: 0.5rem;
    height: 0.5rem;
    flex: 0 0 auto;
    border-radius: 50%;
    background: #d7f58c;
    box-shadow: 0 0 1.1rem rgb(215 245 140 / 70%);
  }

  .home-hero__since {
    margin-left: 0.6rem;
    color: rgb(255 255 255 / 62%);
  }

  .home-hero h1 {
    max-width: none;
    margin: 0;
    font-family: "Montserrat", sans-serif;
    font-size: clamp(3.75rem, 9vw, 7.5rem);
    font-weight: 700;
    letter-spacing: -0.085em;
    line-height: 0.91;
  }

  .home-hero h1 span,
  .home-hero h1 em {
    display: block;
  }

  .home-hero--ja h1 {
    letter-spacing: -0.045em;
  }

  .home-hero h1 em {
    color: #d7f58c;
    font-style: normal;
  }

  .home-hero__intro {
    max-width: 33rem;
    margin: 1.5rem 0 0;
    color: rgb(255 255 255 / 76%);
    font-size: clamp(0.95rem, 1.5vw, 1.1rem);
    line-height: 1.7;
  }

  .home-hero__actions {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 1rem 1.5rem;
    margin-top: 2rem;
  }

  .home-hero__primary,
  .home-hero__secondary {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.8rem;
    text-decoration: none;
    transition: background-color 180ms ease, color 180ms ease, transform 180ms ease;
  }

  .home-hero__primary {
    min-height: 3.25rem;
    border-radius: 9999px;
    background: #d7f58c;
    padding: 0.75rem 1.25rem;
    color: #111;
    font-size: 0.8rem;
    font-weight: 700;
  }

  .home-hero__primary:hover {
    transform: translateY(-2px);
    background: #e5ffab;
  }

  .home-hero__secondary {
    min-height: 3rem;
    color: white;
    font-size: 0.8rem;
    font-weight: 600;
  }

  .home-hero__secondary:hover {
    color: #d7f58c;
  }

  .home-hero__primary:focus-visible,
  .home-hero__secondary:focus-visible {
    outline: 2px solid white;
    outline-offset: 4px;
  }

  .home-hero__caption {
    position: absolute;
    right: max(1.5rem, calc((100vw - 76rem) / 2));
    bottom: 2.25rem;
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
    margin: 0;
    color: rgb(255 255 255 / 76%);
    font-size: 0.58rem;
    letter-spacing: 0.16em;
    text-align: right;
  }

  .home-hero__caption span:first-child {
    color: #d7f58c;
  }

  .home-hero__index {
    position: absolute;
    bottom: 2.25rem;
    left: max(1.5rem, calc((100vw - 76rem) / 2));
    color: rgb(255 255 255 / 58%);
    font-size: 0.58rem;
    letter-spacing: 0.18em;
  }

  .home-genres {
    width: 100vw;
    margin-inline: calc(50% - 50vw);
    border-block: 1px solid rgb(255 255 255 / 9%);
    background: #0b0c0b;
  }

  .home-genres__inner {
    display: flex;
    width: min(76rem, calc(100% - 3rem));
    min-height: 5.25rem;
    margin-inline: auto;
    align-items: center;
    justify-content: space-between;
    gap: 1.5rem;
  }

  .home-genres__inner > p,
  .home-section__eyebrow {
    margin: 0;
    color: #a3a3a3;
    font-size: 0.6rem;
    font-weight: 600;
    letter-spacing: 0.17em;
    text-transform: uppercase;
  }

  .home-genres ul {
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-end;
    gap: 0.7rem 1.75rem;
    margin: 0;
    padding: 0;
    list-style: none;
  }

  .home-genres li {
    color: #e5e5e5;
    font-size: 0.7rem;
    font-weight: 600;
    letter-spacing: 0.03em;
  }

  .upcoming-events {
    border-top: 1px solid rgb(255 255 255 / 10%);
    padding-block: 3rem 2rem;
  }

  .upcoming-events__heading {
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    gap: 1rem;
  }

  .home-section__eyebrow {
    margin-bottom: 0.65rem;
    color: #b8d978;
  }

  .upcoming-events h2 {
    margin: 0;
    font-size: clamp(1.4rem, 4vw, 1.85rem);
    font-weight: 650;
    letter-spacing: -0.04em;
  }

  .upcoming-events__heading a {
    display: inline-flex;
    flex: 0 0 auto;
    align-items: center;
    gap: 0.45rem;
    padding-bottom: 0.25rem;
    color: #a3a3a3;
    font-size: 0.7rem;
    text-decoration: none;
    transition: color 160ms ease;
  }

  .upcoming-events__heading a:hover {
    color: white;
  }

  .upcoming-events__heading a:focus-visible,
  .venue-cta a:focus-visible {
    outline: 2px solid white;
    outline-offset: 4px;
  }

  .upcoming-events__empty {
    display: flex;
    min-height: 4rem;
    align-items: center;
    gap: 0.85rem;
    margin: 1.25rem 0 0;
    border: 1px solid rgb(255 255 255 / 8%);
    border-radius: 0.65rem;
    background: linear-gradient(110deg, rgb(255 255 255 / 4%), rgb(255 255 255 / 1%));
    padding: 1rem;
  }

  .upcoming-events__empty p {
    margin: 0;
    color: #b5b5b5;
    font-size: 0.8rem;
    line-height: 1.6;
  }

  .venue-cta {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1.5rem;
    margin-block: 1rem 3rem;
    border: 1px solid rgb(201 239 106 / 25%);
    border-radius: 0.75rem;
    background:
      radial-gradient(ellipse at 8% 100%, rgb(201 239 106 / 10%), transparent 48%),
      linear-gradient(110deg, #12150e, #0b0b0b 70%);
    padding: 1.5rem;
  }

  .venue-cta p {
    margin: 0 0 0.45rem;
    color: #b8d978;
    font-size: 0.62rem;
    font-weight: 600;
    letter-spacing: 0.13em;
    text-transform: uppercase;
  }

  .venue-cta h2 {
    max-width: 28rem;
    margin: 0;
    font-size: clamp(1.05rem, 3vw, 1.35rem);
    font-weight: 600;
    line-height: 1.4;
  }

  .venue-cta a {
    display: inline-flex;
    flex: 0 0 auto;
    align-items: center;
    gap: 0.55rem;
    border-radius: 9999px;
    background: #d7f58c;
    padding: 0.75rem 1rem;
    color: #111;
    font-size: 0.7rem;
    font-weight: 700;
    text-decoration: none;
    transition: background-color 160ms ease, transform 160ms ease;
  }

  .venue-cta a:hover {
    transform: translateY(-1px);
    background: #e5ffab;
  }

  @media (max-width: 640px) {
    .home-hero {
      min-height: min(48rem, max(39rem, calc(100svh - 5.25rem)));
    }

    .home-hero__image img {
      object-position: 58% center;
    }

    .home-hero__image::after {
      background:
        linear-gradient(90deg, rgb(5 7 9 / 78%), rgb(5 7 9 / 38%) 72%, rgb(5 7 9 / 16%)),
        linear-gradient(0deg, #080909 0%, rgb(8 9 9 / 76%) 22%, transparent 72%),
        linear-gradient(180deg, rgb(8 9 9 / 40%), transparent 24%);
    }

    .home-hero__content {
      width: calc(100% - 2.5rem);
      padding-block: 6rem 8rem;
    }

    .home-hero__eyebrow {
      flex-wrap: wrap;
      gap: 0.55rem;
      font-size: 0.58rem;
    }

    .home-hero__since {
      margin-left: 0.25rem;
    }

    .home-hero h1 {
      max-width: 100%;
      font-size: clamp(3.45rem, 12vw, 5rem);
    }

    .home-hero h1 span,
    .home-hero h1 em {
      white-space: normal;
    }

    .home-hero__intro {
      max-width: 27rem;
      font-size: 0.9rem;
    }

    .home-hero__caption {
      right: 1.25rem;
      bottom: 1.5rem;
    }

    .home-hero__index {
      bottom: 1.5rem;
      left: 1.25rem;
    }

    .home-genres__inner {
      width: calc(100% - 2.5rem);
      min-height: 6rem;
      align-items: flex-start;
      flex-direction: column;
      justify-content: center;
      gap: 0.7rem;
    }

    .home-genres ul {
      justify-content: flex-start;
      gap: 0.65rem 1.15rem;
    }

    .home-genres li {
      font-size: 0.65rem;
    }

    .upcoming-events {
      padding-block: 2.5rem 1.5rem;
    }

    .venue-cta {
      align-items: flex-start;
      flex-direction: column;
      gap: 1rem;
      margin-bottom: 2.5rem;
      padding: 1.25rem;
    }
  }

  @media (max-width: 380px) {
    .home-hero__content {
      width: calc(100% - 2rem);
    }

    .home-hero h1 {
      font-size: clamp(3rem, 12vw, 3.45rem);
    }

    .home-hero__actions {
      gap: 0.5rem 1rem;
    }

    .home-hero__primary {
      padding-inline: 1rem;
    }

    .upcoming-events__heading {
      align-items: flex-start;
      flex-direction: column;
      gap: 0.75rem;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .home-hero__primary,
    .home-hero__secondary,
    .upcoming-events__heading a,
    .venue-cta a {
      transition: none;
    }
  }
</style>
