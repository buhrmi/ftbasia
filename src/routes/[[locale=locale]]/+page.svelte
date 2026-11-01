<script>
  import "@fontsource/montserrat/300.css";
  import logo from "~/assets/logo.png";
  import NewsIndex from "~/pages/news/index.svelte";
  import PageMeta from "~/shared/PageMeta.svelte";

  let { data } = $props();

  const genres = [
    { name: "Drum n Bass", style: "dnb" },
    { name: "Dubstep", style: "dubstep" },
    { name: "Trap", style: "trap" },
    { name: "Electro", style: "electro" }
  ];
</script>

<PageMeta meta={data.meta} />

<section class="home-hero" aria-labelledby="home-tagline">
  <img class="home-hero__logo" src={logo} alt="Follow The Bass" />
  <h1 id="home-tagline">The independent bass music festival in Tokyo and beyond</h1>
  <ul class="home-hero__genres" aria-label="Genres">
  {#each genres as genre (genre.name)}
    <li class="genre-badge genre-badge--{genre.style}">{genre.name}</li>
    {/each}
  </ul>
</section>

<NewsIndex news={data.news} locale={data.locale} meta={data.meta} />

<style>
  .home-hero {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1.25rem;
    padding-block: 2rem 3rem;
    text-align: center;
  }

  .home-hero__logo {
    width: min(15rem, 65vw);
    height: auto;
    object-fit: contain;
  }

  .home-hero h1 {
    max-width: 38rem;
    margin: 0;
    color: #f0ede7;
    font-family: "Montserrat", sans-serif;
    font-size: clamp(1.5rem, 5vw, 2.5rem);
    font-weight: 300;
    line-height: 1.25;
    letter-spacing: 0.01em;
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

  .genre-badge--electro {
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
</style>
