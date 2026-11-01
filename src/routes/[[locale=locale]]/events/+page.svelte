<script>
  import PageMeta from "~/shared/PageMeta.svelte";
  import { profileAsset } from "~/profiles.js";

  let { data } = $props();

  const title = $derived(data.locale === "ja" ? "過去のイベント" : "Past events");
</script>

<PageMeta meta={data.meta} />

<main class="events-index">
  <h1>{title}</h1>
  {#if data.events.length}
    <ul class="events-grid">
      {#each data.events as event (event.slug)}
        <li class="event-card">
          <a href={event.url} class="event-card__link">
            <div class="event-card__background" aria-hidden="true">
              {#if event.flyer}
                <img src={profileAsset("events", event.flyer)} alt="" loading="lazy" />
              {/if}
            </div>
            <div class="event-card__shade" aria-hidden="true"></div>
            <div class="event-card__content">
              {#if event.starts_at}
                <time datetime={event.starts_at}>
                  {new Intl.DateTimeFormat(data.locale, {
                    dateStyle: "long",
                    timeZone: "Asia/Tokyo"
                  }).format(new Date(event.starts_at))}
                </time>
              {/if}
              <h2>{event.name}</h2>
            </div>
          </a>
        </li>
      {/each}
    </ul>
  {:else}
    <p class="empty-state">
      {data.locale === "ja" ? "過去のイベントはありません。" : "No past events yet."}
    </p>
  {/if}
</main>

<style>
  .events-index h1 {
    margin: 0 0 1.5rem;
    font-size: 1.5rem;
    font-weight: 600;
    letter-spacing: -0.03em;
  }

  .events-grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 0;
    margin: 0;
    padding: 0;
    list-style: none;
  }

  .event-card {
    min-width: 0;
    margin: 0;
  }

  .event-card__link {
    position: relative;
    isolation: isolate;
    display: flex;
    min-height: 18rem;
    height: 100%;
    flex-direction: column;
    justify-content: flex-end;
    overflow: hidden;
    background: #171717;
    color: inherit;
    text-decoration: none;
  }

  .event-card__link:focus-visible {
    z-index: 1;
    outline: 2px solid white;
    outline-offset: -4px;
  }

  .event-card__background,
  .event-card__shade {
    position: absolute;
    inset: 0;
  }

  .event-card__background {
    z-index: 0;
    background:
      radial-gradient(ellipse at 70% 20%, rgb(82 82 91 / 35%), transparent 55%),
      linear-gradient(135deg, #262626, #090909);
    transition: transform 500ms cubic-bezier(0.2, 0.7, 0.2, 1);
  }

  .event-card__background img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .event-card__shade {
    z-index: 1;
    background: linear-gradient(
      180deg,
      rgb(0 0 0 / 8%) 0%,
      rgb(0 0 0 / 24%) 38%,
      rgb(0 0 0 / 86%) 100%
    );
  }

  .event-card__content {
    position: relative;
    z-index: 2;
    padding: 1.25rem;
  }

  .event-card time {
    color: #d4d4d4;
    font-size: 0.6875rem;
    letter-spacing: 0.16em;
    text-transform: uppercase;
  }

  .event-card h2 {
    margin: 0.5rem 0 0;
    font-size: 1.125rem;
    font-weight: 600;
    line-height: 1.35;
  }

  .event-card__link:hover .event-card__background {
    transform: scale(1.045);
  }

  .empty-state {
    color: #a3a3a3;
  }

  @media (max-width: 640px) {
    .events-grid {
      grid-template-columns: minmax(0, 1fr);
    }

    .event-card__link {
      min-height: 16rem;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .event-card__background {
      transition: none;
    }

    .event-card__link:hover .event-card__background {
      transform: none;
    }
  }
</style>
