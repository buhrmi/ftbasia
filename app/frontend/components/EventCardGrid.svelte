<script>
  import { Link } from "@inertiajs/svelte";

  let { events = [], locale = "en" } = $props();

  function displayDate(event) {
    if (!event.starts_at) return "";
    return new Intl.DateTimeFormat(locale, {
      dateStyle: "long",
      ...(event.all_day ? {} : { timeStyle: "short" }),
      timeZone: event.timezone
    }).format(new Date(event.starts_at));
  }
</script>

{#if events.length}
  <ul class="events-grid">
    {#each events as event (event.slug)}
      <li class="event-card">
        <Link href={event.url} class="event-card__link">
          <div class="event-card__background" aria-hidden="true">
            {#if event.flyer?.url}
              <img src={event.flyer.url} alt="" loading="lazy" />
            {/if}
          </div>
          <div class="event-card__shade" aria-hidden="true"></div>
          <div class="event-card__content">
            {#if event.starts_at}<time datetime={event.starts_at}>{displayDate(event)}</time>{/if}
            <h2>{event.name}</h2>
          </div>
        </Link>
      </li>
    {/each}
  </ul>
{/if}
