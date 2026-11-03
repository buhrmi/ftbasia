<script>
  import PageMeta from "~/shared/PageMeta.svelte";
  import { profileImage } from "~/profiles.js";

  let { data } = $props();

  const japanese = $derived(data.locale === "ja");
</script>

<PageMeta meta={data.meta} />

<main class="content-index content-index--artists">
  <header class="content-index__heading">
    <p class="content-index__eyebrow">{japanese ? "Follow The Bass · ベースミュージック" : "Follow The Bass · Bass music"}</p>
    <h1 class="content-index__title">{japanese ? "アーティスト" : "Artists"}</h1>
    <p class="content-index__intro">
      {japanese
        ? "それぞれのスタイルでベースミュージックを形づくるアーティストたち。"
        : "Meet the artists shaping bass music in their own distinct ways."}
    </p>
  </header>

  {#if data.artists.length}
    <ul class="content-index__grid">
      {#each data.artists as artist, index (artist.slug)}
        {@const image = profileImage("artists", artist.slug)}
        <li class="content-index__card artist-card">
          <a class="content-index__card-link" href={artist.url}>
            <div class="content-index__image">
              {#if image}
                <img
                  src={image}
                  alt=""
                  loading="lazy"
                  class:top-aligned={artist.slug === "allen-mock"}
                />
              {:else}
                <div class="content-index__image-fallback" aria-hidden="true"></div>
              {/if}
              <span class="artist-card__number" aria-hidden="true">
                {String(index + 1).padStart(2, "0")}
              </span>
            </div>
            <div class="artist-card__content content-index__card-content">
              {#if artist.location}
                <p class="artist-card__location">{artist.location}</p>
              {/if}
              <h2 class="content-index__card-title">{artist.name}</h2>
              {#if artist.role}
                <p class="artist-card__role">{artist.role}</p>
              {/if}
              {#if artist.tagline}
                <p class="artist-card__tagline">{artist.tagline}</p>
              {:else if artist.bio}
                <p class="artist-card__tagline">{artist.bio}</p>
              {/if}
              <span class="content-index__more">
                {japanese ? "プロフィールを見る" : "View profile"}
                <span class="content-index__more-icon" aria-hidden="true">↗</span>
              </span>
            </div>
          </a>
        </li>
      {/each}
    </ul>
  {:else}
    <p class="content-index__empty">
      {japanese ? "アーティスト情報は準備中です。" : "Artist profiles are coming soon."}
    </p>
  {/if}
</main>

<style>
  .content-index__image img.top-aligned {
    object-position: top;
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

  .artist-card__location {
    margin: 0 0 0.6rem;
    color: #a3a3a3;
    font-size: 0.625rem;
    letter-spacing: 0.12em;
    text-transform: uppercase;
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

  @media (max-width: 540px) {
    .content-index__grid {
      grid-template-columns: minmax(0, 1fr);
      gap: 0.85rem;
    }

    .content-index__card-link {
      display: grid;
      grid-template-columns: minmax(7rem, 0.85fr) minmax(0, 1.15fr);
    }

    .content-index__image {
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

</style>
