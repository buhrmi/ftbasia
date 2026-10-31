<script>
  import { formatShowDate, showAsset, showUrl } from "~/shows.js";

  let { shows, locale } = $props();

  const heading = $derived(locale === "ja" ? "公演" : "Shows");
  const workHeading = $derived(locale === "ja" ? "私たちが担当したこと" : "What we did");
  const performerLabel = $derived(locale === "ja" ? "出演" : "Performer");
</script>

{#if shows?.length}
  <section class="mt-12">
    <h2 class="mb-6 text-lg font-semibold">{heading}</h2>
    <div class="grid gap-8">
      {#each shows as show (show.slug)}
        {@const flyer = show.flyer ? showAsset(show.flyer) : undefined}
        <article class="rounded-lg border border-white/10 p-5">
          <div class="flex flex-col gap-6 sm:flex-row sm:items-start">
            {#if flyer}
              <a href={showUrl(show.slug, locale)} class="block shrink-0 sm:w-52">
                <img
                  src={flyer}
                  alt={`${show.name} flyer`}
                  width="750"
                  height="750"
                  loading="lazy"
                  class="w-full rounded border border-white/10"
                />
              </a>
            {/if}
            <div class="min-w-0">
              <p class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase">
                {show.year}{#if show.kind}{" / "}{show.kind}{/if}
              </p>
              <h3 class="mt-2 text-lg font-semibold">
                <a href={showUrl(show.slug, locale)} class="hover:underline">{show.name}</a>
              </h3>
              <p class="mt-1 text-sm text-neutral-500">
                {formatShowDate(show.starts_at, locale)}{#if show.location}{" · "}{show.location}{/if}
              </p>
              {#if show.description}
                <p class="mt-3 text-sm leading-relaxed text-neutral-400">{show.description}</p>
              {/if}
              {#if show.performers?.length}
                <p class="mt-3 text-sm text-neutral-300">
                  <span class="text-neutral-500">{performerLabel}:</span>
                  {show.performers.join(", ")}
                </p>
              {/if}
              {#if show.work?.length}
                <div class="mt-5">
                  <p class="text-[11px] tracking-[0.2em] text-neutral-500 uppercase">{workHeading}</p>
                  <ul class="mt-2 space-y-3">
                    {#each show.work as item (item.title)}
                      <li>
                        <p class="text-sm font-medium text-neutral-200">{item.title}</p>
                        <p class="mt-1 text-sm leading-relaxed text-neutral-400">{item.body}</p>
                      </li>
                    {/each}
                  </ul>
                </div>
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
            </div>
          </div>
        </article>
      {/each}
    </div>
  </section>
{/if}
