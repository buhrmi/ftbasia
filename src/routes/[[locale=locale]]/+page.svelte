<script>
  import "@fontsource/montserrat/300.css";
  import logo from "~/assets/logo.png";
  import NewsIndex from "~/pages/news/index.svelte";
  import PageMeta from "~/shared/PageMeta.svelte";

  let { data } = $props();

  const genres = [
    { name: "Drum & Bass", style: "dnb" },
    { name: "Dubstep", style: "dubstep" },
    { name: "Trap", style: "trap" },
    { name: "Hardstyle", style: "hardstyle" }
  ];
</script>

<PageMeta meta={data.meta} />

<section class="home-hero" aria-labelledby="home-tagline">
  <img class="home-hero__logo" src={logo} alt="Follow The Bass" />
  <h1 id="home-tagline">Bass music culture in Tokyo and beyond. Est 2014.</h1>
  <ul class="home-hero__genres" aria-label="Genres">
  {#each genres as genre (genre.name)}
    <li class="genre-badge genre-badge--{genre.style}">{genre.name}</li>
    {/each}
  </ul>
</section>


<section class="upcoming-events" aria-labelledby="upcoming-events-heading">
  <div class="upcoming-events__heading">
    <h2 id="upcoming-events-heading">{data.locale === "ja" ? "今後のイベント" : "Upcoming events"}</h2>
    <a href={data.locale === "en" ? "/en/events" : "/events"}>
      {data.locale === "ja" ? "過去のイベント" : "Past events"}
      <span aria-hidden="true">→</span>
    </a>
  </div>
  <p class="upcoming-events__empty">
    {data.locale === "ja"
      ? "イベントはまだ発表されていません。続報をお待ちください。"
      : "No events announced. Check back soon."}
  </p>
</section>

<section class="venue-cta mb-12" aria-labelledby="venue-cta-heading">
  <div>
    <p>{data.locale === "ja" ? "会場オーナー・マネージャーの皆さまへ" : "For venue owners and managers"}</p>
    <h2 id="venue-cta-heading">
      {data.locale === "ja"
        ? "Follow The Bassのイベントを開催しませんか？"
        : "Host a Follow The Bass night"}
    </h2>
  </div>
  <a href={data.locale === "en" ? "/en/partners" : "/partners"}>
    {data.locale === "ja" ? "パートナーについて" : "Explore venue partnerships"}
    <span aria-hidden="true">→</span>
  </a>
</section>

<NewsIndex news={data.news} locale={data.locale} meta={data.meta} compact />

<style>
  .home-hero {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1.25rem;
    padding-block: 2rem 3rem;
    text-align: center;
  }

  .upcoming-events {
    border-top: 1px solid rgb(255 255 255 / 10%);
    padding-block: 1.5rem;
  }

  .upcoming-events__heading {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    gap: 1rem;
  }

  .upcoming-events h2 {
    margin: 0;
    font-size: 1.25rem;
    font-weight: 600;
    letter-spacing: -0.02em;
  }

  .upcoming-events__empty {
    margin: 0.75rem 0 0;
    color: #a3a3a3;
    font-size: 0.875rem;
  }

  .upcoming-events a {
    display: inline-flex;
    flex: 0 0 auto;
    align-items: center;
    gap: 0.4rem;
    color: #a3a3a3;
    font-size: 0.75rem;
    text-decoration: none;
    transition: color 160ms ease;
  }

  .upcoming-events a:hover {
    color: white;
  }

  .upcoming-events a:focus-visible {
    outline: 2px solid white;
    outline-offset: 4px;
  }

  .home-hero__logo {
    width: min(19rem, 75vw);
    height: auto;
    object-fit: contain;
  }

  .home-hero h1 {
    max-width: 38rem;
    margin: 0;
    color: #f0ede7;
    font-family: "Montserrat", sans-serif;
    font-size: clamp(1.25rem, 3.5vw, 1.35rem);
    transform: translateY(-1.5rem);
    font-weight: 300;
    line-height: 1.25;
    letter-spacing: 0.01em;
  }

  .venue-cta {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 1.5rem;
    border: 1px solid rgb(201 239 106 / 25%);
    border-radius: 0.75rem;
    background: linear-gradient(110deg, rgb(201 239 106 / 8%), rgb(255 255 255 / 2%));
    padding: 1.5rem;
  }

  .venue-cta p {
    margin: 0 0 0.35rem;
    color: #b8d978;
    font-size: 0.6875rem;
    font-weight: 600;
    letter-spacing: 0.12em;
    text-transform: uppercase;
  }

  .venue-cta h2 {
    margin: 0;
    font-size: clamp(1.1rem, 3vw, 1.4rem);
    font-weight: 600;
    line-height: 1.35;
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
    font-size: 0.75rem;
    font-weight: 700;
    text-decoration: none;
    transition: background-color 160ms ease, transform 160ms ease;
  }

  .venue-cta a:hover {
    transform: translateY(-1px);
    background: #e5ffab;
  }

  .venue-cta a:focus-visible {
    outline: 2px solid white;
    outline-offset: 4px;
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

  @media (max-width: 560px) {
    .venue-cta {
      align-items: flex-start;
      flex-direction: column;
      gap: 1rem;
    }
  }
</style>
