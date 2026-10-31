<script>
  import { Link } from "inertiax-svelte";
  import { absoluteUrl } from "~/news.js";
  import { formatShowDate, showAsset } from "~/shows.js";

  let { show, event, locale, meta } = $props();

  const flyer = $derived(show.flyer ? showAsset(show.flyer) : undefined);
  const imageUrl = $derived(absoluteUrl(flyer, meta.origin));
  const backLabel = $derived(locale === "ja" ? "← イベント" : "← Event");
  const workHeading = $derived(locale === "ja" ? "私たちが担当したこと" : "What we did");
  const flyerHeading = $derived(locale === "ja" ? "フライヤー" : "Flyer");
  const performerLabel = $derived(locale === "ja" ? "出演" : "Performer");
</script>

<svelte:head>
  {#if imageUrl}
    <meta property="og:image" content={imageUrl} />
    <meta name="twitter:image" content={imageUrl} />
  {/if}
</svelte:head>

{#if event}
  <nav class="mb-10">
    <Link
      href={locale === "en" ? `/en/events/${event.slug}` : `/events/${event.slug}`}
      class="text-sm text-neutral-400 hover:text-white"
    >
      {backLabel}
    </Link>
  </nav>
{/if}

<article>
  <p class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase">
    {show.year}{#if show.kind}{" / "}{show.kind}{/if}
  </p>
  <h1 class="mt-4 text-3xl font-semibold tracking-tight">{show.name}</h1>
  <p class="mt-3 text-sm text-neutral-500">
    {formatShowDate(show.starts_at, locale)}{#if show.location}{" · "}{show.location}{/if}
  </p>
  {#if show.description}
    <p class="mt-6 text-[15px] leading-8 text-neutral-400">{show.description}</p>
  {/if}
  {#if show.performers?.length}
    <p class="mt-4 text-sm text-neutral-300">
      <span class="text-neutral-500">{performerLabel}:</span>
      {show.performers.join(", ")}
    </p>
  {/if}
  {#if show.links?.length}
    <ul class="mt-4 flex flex-wrap gap-x-5 gap-y-2 text-sm">
      {#each show.links as link (link.url)}
        <li>
          <a
            href={link.url}
            target="_blank"
            rel="noopener noreferrer"
            class="underline underline-offset-4"
          >
            {link.label}
          </a>
        </li>
      {/each}
    </ul>
  {/if}
</article>

{#if show.work?.length}
  <section class="mt-12 border-t border-white/10 pt-8">
    <h2 class="text-lg font-semibold">{workHeading}</h2>
    <ul class="mt-6 grid gap-6 sm:grid-cols-2">
      {#each show.work as item (item.title)}
        <li>
          <h3 class="text-sm font-medium text-neutral-200">{item.title}</h3>
          <p class="mt-1 text-sm leading-relaxed text-neutral-400">{item.body}</p>
        </li>
      {/each}
    </ul>
  </section>
{/if}

{#if flyer}
  <section class="mt-12 border-t border-white/10 pt-8">
    <h2 class="text-lg font-semibold">{flyerHeading}</h2>
    <figure class="mt-6">
      <img
        src={flyer}
        alt={`${show.name} flyer`}
        width="750"
        height="750"
        loading="lazy"
        class="mx-auto block w-full max-w-md rounded-lg border border-white/10"
      />
      <figcaption class="mt-4 text-center text-xs text-neutral-500">
        {show.name} — {show.year}
      </figcaption>
    </figure>
  </section>
{/if}
