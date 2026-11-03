<script>
  import PageMeta from "~/shared/PageMeta.svelte";
  import { profileImage } from "~/profiles.js";

  let { data } = $props();

  const japanese = $derived(data.locale === "ja");
</script>

<PageMeta meta={data.meta} />

<main class="artists-index">
  <header class="artists-heading">
    <p class="eyebrow">{japanese ? "Follow The Bass · ベースミュージック" : "Follow The Bass · Bass music"}</p>
    <h1>{japanese ? "アーティスト" : "Artists"}</h1>
    <p class="intro">
      {japanese
        ? "それぞれのスタイルでベースミュージックを形づくるアーティストたち。"
        : "Meet the artists shaping bass music in their own distinct ways."}
    </p>
  </header>

  {#if data.artists.length}
    <ul class="artists-grid">
      {#each data.artists as artist, index (artist.slug)}
        {@const image = profileImage("artists", artist.slug)}
        <li class="artist-card">
          <a class="artist-card__link" href={artist.url}>
            <div class="artist-card__image">
              {#if image}
                <img
                  src={image}
                  alt=""
                  loading="lazy"
                  class:top-aligned={artist.slug === "allen-mock"}
                />
              {:else}
                <div class="artist-card__image-fallback" aria-hidden="true"></div>
              {/if}
              <span class="artist-card__number" aria-hidden="true">
                {String(index + 1).padStart(2, "0")}
              </span>
            </div>
            <div class="artist-card__content">
              {#if artist.location}
                <p class="artist-card__location">{artist.location}</p>
              {/if}
              <h2>{artist.name}</h2>
              {#if artist.role}
                <p class="artist-card__role">{artist.role}</p>
              {/if}
              {#if artist.tagline}
                <p class="artist-card__tagline">{artist.tagline}</p>
              {:else if artist.bio}
                <p class="artist-card__tagline">{artist.bio}</p>
              {/if}
              <span class="artist-card__more">
                {japanese ? "プロフィールを見る" : "View profile"}
                <span aria-hidden="true">↗</span>
              </span>
            </div>
          </a>
        </li>
      {/each}
    </ul>
  {:else}
    <p class="empty-state">
      {japanese ? "アーティスト情報は準備中です。" : "Artist profiles are coming soon."}
    </p>
  {/if}
</main>

<style>
  .artists-index {
    padding-block: 2rem 4rem;
  }

  .artists-heading {
    max-width: 38rem;
    margin-bottom: 2rem;
  }

  .eyebrow {
    margin: 0 0 0.75rem;
    color: #b8d978;
    font-size: 0.6875rem;
    font-weight: 600;
    letter-spacing: 0.16em;
    text-transform: uppercase;
  }

  .artists-heading h1 {
    margin: 0;
    font-size: clamp(2.5rem, 8vw, 4.5rem);
    font-weight: 700;
    letter-spacing: -0.06em;
    line-height: 1;
  }

  .intro {
    max-width: 32rem;
    margin: 1rem 0 0;
    color: #a3a3a3;
    font-size: 1rem;
    line-height: 1.7;
  }

  .artists-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 1rem;
    margin: 0;
    padding: 0;
    list-style: none;
  }

  .artist-card {
    min-width: 0;
  }

  .artist-card__link {
    display: flex;
    height: 100%;
    flex-direction: column;
    overflow: hidden;
    border: 1px solid rgb(255 255 255 / 9%);
    border-radius: 0.8rem;
    background: linear-gradient(155deg, #171717, #0b0b0b 70%);
    color: inherit;
    text-decoration: none;
    transition:
      border-color 180ms ease,
      transform 180ms ease,
      background-color 180ms ease;
  }

  .artist-card__link:hover {
    transform: translateY(-3px);
    border-color: rgb(201 239 106 / 45%);
  }

  .artist-card__link:focus-visible {
    outline: 2px solid #d7f58c;
    outline-offset: 4px;
  }

  .artist-card__image {
    position: relative;
    overflow: hidden;
    aspect-ratio: 1.35;
    background: #171717;
  }

  .artist-card__image::after {
    position: absolute;
    inset: 45% 0 0;
    background: linear-gradient(180deg, transparent, rgb(0 0 0 / 45%));
    content: "";
    pointer-events: none;
  }

  .artist-card__image img,
  .artist-card__image-fallback {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 450ms cubic-bezier(0.2, 0.7, 0.2, 1);
  }

  .artist-card__image img.top-aligned {
    object-position: top;
  }

  .artist-card__image-fallback {
    background:
      radial-gradient(ellipse at 70% 20%, rgb(82 82 91 / 35%), transparent 55%),
      linear-gradient(135deg, #262626, #090909);
  }

  .artist-card__link:hover .artist-card__image img {
    transform: scale(1.045);
  }

  .artist-card__number {
    position: absolute;
    z-index: 1;
    right: 0.85rem;
    bottom: 0.7rem;
    color: rgb(255 255 255 / 75%);
    font-size: 0.65rem;
    font-variant-numeric: tabular-nums;
    letter-spacing: 0.12em;
  }

  .artist-card__content {
    display: flex;
    flex: 1;
    flex-direction: column;
    align-items: flex-start;
    padding: 1rem;
  }

  .artist-card__location {
    margin: 0 0 0.6rem;
    color: #a3a3a3;
    font-size: 0.625rem;
    letter-spacing: 0.12em;
    text-transform: uppercase;
  }

  .artist-card h2 {
    margin: 0;
    font-size: clamp(1.1rem, 3vw, 1.45rem);
    font-weight: 650;
    letter-spacing: -0.03em;
    line-height: 1.2;
  }

  .artist-card__role {
    margin: 0.4rem 0 0;
    color: #d7f58c;
    font-size: 0.75rem;
    line-height: 1.5;
  }

  .artist-card__tagline {
    display: -webkit-box;
    overflow: hidden;
    margin: 0.75rem 0 1.25rem;
    color: #a3a3a3;
    font-size: 0.8rem;
    line-height: 1.65;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 3;
  }

  .artist-card__more {
    display: flex;
    width: 100%;
    align-items: center;
    justify-content: space-between;
    gap: 0.75rem;
    margin-top: auto;
    border-top: 1px solid rgb(255 255 255 / 9%);
    padding-top: 0.8rem;
    color: #e5e5e5;
    font-size: 0.7rem;
    font-weight: 600;
  }

  .artist-card__more span {
    color: #d7f58c;
    font-size: 1rem;
    transition: transform 180ms ease;
  }

  .artist-card__link:hover .artist-card__more span {
    transform: translate(2px, -2px);
  }

  .empty-state {
    color: #a3a3a3;
  }

  @media (max-width: 540px) {
    .artists-grid {
      grid-template-columns: minmax(0, 1fr);
      gap: 0.85rem;
    }

    .artist-card__link {
      display: grid;
      grid-template-columns: minmax(7rem, 0.85fr) minmax(0, 1.15fr);
    }

    .artist-card__image {
      min-height: 100%;
      aspect-ratio: auto;
    }

    .artist-card__content {
      padding: 0.9rem;
    }

    .artist-card__tagline {
      margin-block: 0.55rem 0.85rem;
      -webkit-line-clamp: 2;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .artist-card__link,
    .artist-card__image img,
    .artist-card__more span {
      transition: none;
    }

    .artist-card__link:hover {
      transform: none;
    }

    .artist-card__link:hover .artist-card__image img {
      transform: none;
    }
  }
</style>
