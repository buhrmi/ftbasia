<script>
  import { Link } from "inertiax-svelte";
  import logo from "~/assets/logo.png";
  import { absoluteUrl, formatNewsDate, newsImage } from "~/news.js";

  let { news, locale = "en", meta } = $props();

  const imageUrl = $derived(absoluteUrl(logo, meta.origin));
</script>

<svelte:head>
  {#if imageUrl}
    <meta property="og:image" content={imageUrl} />
    <meta name="twitter:image" content={imageUrl} />
  {/if}
</svelte:head>

<main class="news-index">
  <h1 class="mb-6 text-2xl font-semibold tracking-tight">News</h1>

  {#if news.length}
    <ul class="news-grid">
      {#each news as item (item.slug)}
        {@const preview = newsImage(item.slug, locale)}
        <li class="news-card">
          <Link href={item.url} class="news-card__link group">
            <div class="news-card__background" aria-hidden="true">
              {#if preview}
                <img src={preview} alt="" loading="lazy" />
              {:else}
                <div class="news-card__fallback"></div>
              {/if}
            </div>
            <div class="news-card__shade" aria-hidden="true"></div>
            <div class="news-card__content">
              <div class="news-card__meta">
                {#if item.category}
                  <span class="news-card__category">{item.category}</span>
                {/if}
                <time
                  datetime={item.published_at}
                  class="text-[11px] tracking-[0.25em] text-neutral-300 uppercase"
                >
                  {formatNewsDate(item.published_at, locale)}
                </time>
              </div>
              <h2 class="mt-2 text-lg font-semibold leading-snug">{item.title}</h2>
              
            </div>
          </Link>
        </li>
      {/each}
    </ul>
  {:else}
    <p class="text-neutral-400">No news yet.</p>
  {/if}
</main>

<style>
  .news-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 0;
    margin: 0;
    padding: 0;
    list-style: none;
  }

  .news-card {
    min-width: 0;
    margin: 0;
  }

  :global(.news-card__link) {
    position: relative;
    isolation: isolate;
    display: flex;
    min-height: 18rem;
    height: 100%;
    flex-direction: column;
    justify-content: flex-end;
    overflow: hidden;
    border: 0;
    border-radius: 0;
    background: #171717;
    color: inherit;
    text-decoration: none;
    transition: border-color 200ms ease;
  }

  :global(.news-card__link:focus-visible) {
    outline: 2px solid white;
    outline-offset: 3px;
  }

  .news-card__background,
  .news-card__fallback,
  .news-card__shade {
    position: absolute;
    inset: 0;
  }

  .news-card__background {
    z-index: 0;
    transition: transform 500ms cubic-bezier(0.2, 0.7, 0.2, 1);
  }

  .news-card__background img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .news-card__fallback {
    background:
      radial-gradient(ellipse at 70% 20%, rgb(82 82 91 / 35%), transparent 55%),
      linear-gradient(135deg, #262626, #090909);
  }

  .news-card__shade {
    z-index: 1;
    background: linear-gradient(
      180deg,
      rgb(0 0 0 / 8%) 0%,
      rgb(0 0 0 / 24%) 38%,
      rgb(0 0 0 / 86%) 100%
    );
  }

  .news-card__content {
    position: relative;
    z-index: 2;
    padding: 1.25rem;
  }

  .news-card__meta {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 0.65rem;
  }

  .news-card__category {
    border: 1px solid rgb(255 255 255 / 45%);
    border-radius: 9999px;
    padding: 0.2rem 0.55rem;
    color: white;
    font-size: 0.625rem;
    font-weight: 600;
    letter-spacing: 0.12em;
    line-height: 1.25;
  }

  :global(.news-card__link:hover) .news-card__background {
    transform: scale(1.045);
  }

  @media (max-width: 640px) {
    .news-grid {
      grid-template-columns: minmax(0, 1fr);
    }

    :global(.news-card__link) {
      min-height: 16rem;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .news-card__background,
    :global(.news-card__link) {
      transition: none;
    }

    :global(.news-card__link:hover) .news-card__background {
      transform: none;
    }
  }
</style>
