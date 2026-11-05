<script>
  import "@fontsource/montserrat/300.css";
  import logo from "~/assets/logo.png";
  import EventCardGrid from "~/shared/EventCardGrid.svelte";
  import NewsIndex from "~/pages/news/index.svelte";
  import PageMeta from "~/shared/PageMeta.svelte";

  let { data } = $props();

  const japanese = $derived(data.locale === "ja");
  const localePrefix = $derived(japanese ? "" : "/en");
  const genres = [
    { name: "Drum & Bass", style: "dnb" },
    { name: "Dubstep", style: "dubstep" },
    { name: "Trap", style: "trap" },
    { name: "Hardstyle", style: "hardstyle" }
  ];
</script>

<PageMeta meta={data.meta} />

<main class="home-page">
  <section class="home-hero" aria-labelledby="home-title">
    <h1 id="home-title" class="home-hero__title">Follow The Bass</h1>
    <img class="home-hero__logo" src={logo} alt="" fetchpriority="high" />
    <p class="home-hero__tagline">
      Bass music culture in Tokyo and beyond.
    </p>
    <ul class="home-hero__genres" aria-label={japanese ? "ジャンル" : "Genres"}>
      {#each genres as genre (genre.name)}
        <li class="genre-badge genre-badge--{genre.style}">{genre.name}</li>
      {/each}
    </ul>
  </section>

  <section class="upcoming-events" aria-labelledby="upcoming-events-heading">
    <div class="upcoming-events__heading">
      <div>
        <h2 id="upcoming-events-heading">{japanese ? "今後のイベント" : "Upcoming events"}</h2>
      </div>
      <a href={`${localePrefix}/events`}>
        {japanese ? "過去のイベント" : "Event archive"}
        <span aria-hidden="true">↗</span>
      </a>
    </div>
    {#if data.events.length}
      <div class="upcoming-events__list">
        <EventCardGrid events={data.events} locale={data.locale} />
      </div>
    {:else}
      <div class="upcoming-events__empty">
        <span class="upcoming-events__signal" aria-hidden="true"></span>
        <p>
          {japanese
            ? "次のイベントはまだ発表されていません。続報をお待ちください。"
            : "The next event is still under wraps. Stay tuned for the announcement."}
        </p>
      </div>
    {/if}
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
    min-height: min(28rem, max(20rem, calc(100svh - 5.25rem)));
    align-items: center;
    justify-content: center;
    flex-direction: column;
    gap: 1.15rem;
    overflow: hidden;
    margin-inline: calc(50% - 50vw);
    background: #000;
  }

  .home-hero__title {
    position: absolute;
    width: 1px;
    height: 1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    clip-path: inset(50%);
  }

  .home-hero__logo {
    width: min(19rem, 75vw);
    height: auto;
    object-fit: contain;
  }

  .home-hero__tagline {
    margin: 0;
    color: #f0ede7;
    font-family: "Montserrat", sans-serif;
    font-size: clamp(0.9rem, 2.5vw, 1.4rem);
    font-weight: 300;
    line-height: 1.5;
    text-align: center;
    margin-top: -2rem;
  }

  .home-hero__genres {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 0.6rem;
    margin: 0;
    padding: 0;
    list-style: none;
  }

  .genre-badge {
        font-family: "Montserrat", sans-serif;
    border-radius: 9999px;
    padding: 0.45rem 0.85rem;
    font-size: 0.75rem;
    font-weight: 600;
    letter-spacing: 0.04em;
  }

  .genre-badge--dnb {
    border: 1px solid rgb(201 239 106 / 50%);
    background: rgb(201 239 106 / 12%);
    color: #d7f58c;
  }

  .genre-badge--dubstep {
    border: 1px solid rgb(184 147 255 / 50%);
    background: rgb(184 147 255 / 12%);
    color: #cfb5ff;
  }

  .genre-badge--trap {
    border: 1px solid rgb(255 151 121 / 50%);
    background: rgb(255 151 121 / 12%);
    color: #ffb09a;
  }

  .genre-badge--hardstyle {
    border: 1px solid rgb(111 216 235 / 50%);
    background: rgb(111 216 235 / 12%);
    color: #9ce8f5;
  }

  @media (max-width: 420px) {
    .home-hero__genres {
      display: grid;
      grid-template-columns: repeat(2, max-content);
      gap: 0.5rem;
    }
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

  .upcoming-events__list {
    margin-top: 1.25rem;
  }

  .upcoming-events__signal {
    width: 0.5rem;
    height: 0.5rem;
    flex: 0 0 auto;
    border-radius: 50%;
    background: #d7f58c;
    box-shadow: 0 0 1.1rem rgb(215 245 140 / 70%);
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
    .upcoming-events__heading {
      align-items: flex-start;
      flex-direction: column;
      gap: 0.75rem;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .upcoming-events__heading a,
    .venue-cta a {
      transition: none;
    }
  }
</style>
