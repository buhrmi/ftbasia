<script>
  let { event, locale = "en" } = $props();
  const japanese = $derived(locale === "ja");

  const date = $derived.by(() => {
    if (!event.starts_at) return "";
    return new Intl.DateTimeFormat(locale, {
      dateStyle: "long",
      ...(event.all_day ? {} : { timeStyle: "short" }),
      timeZone: event.timezone
    }).format(new Date(event.starts_at));
  });
</script>

<section class="mt-10 border-t border-white/10 pt-8">
  <h2 class="text-lg font-semibold">{japanese ? "イベント詳細" : "Event details"}</h2>
  {#if event.flyer?.url}
    <figure class="mt-5">
      <img src={event.flyer.url} alt={event.flyer.alt_text ?? event.name} loading="lazy" class="block w-full rounded-lg border border-white/10" />
      {#if event.flyer.caption}<figcaption class="mt-2 text-center text-xs text-neutral-500">{event.flyer.caption}</figcaption>{/if}
    </figure>
  {/if}
  <dl class="mt-5 space-y-3 text-sm">
    {#if date}<div><dt class="text-neutral-500">{japanese ? "日時" : "Date"}</dt><dd class="mt-1 text-neutral-200">{date}</dd></div>{/if}
    {#if event.venue}<div><dt class="text-neutral-500">{japanese ? "会場" : "Venue"}</dt><dd class="mt-1 text-neutral-200">{event.venue.name}{event.venue.location ? ` · ${event.venue.location}` : ""}</dd></div>{/if}
    {#if event.location}<div><dt class="text-neutral-500">{japanese ? "所在地" : "Location"}</dt><dd class="mt-1 text-neutral-200">{event.location}</dd></div>{/if}
    {#if event.kind}<div><dt class="text-neutral-500">{japanese ? "イベント種別" : "Event type"}</dt><dd class="mt-1 text-neutral-200">{event.kind}</dd></div>{/if}
    {#if event.performers.length}<div><dt class="text-neutral-500">{japanese ? "出演" : "Performers"}</dt><dd class="mt-1 text-neutral-200">{event.performers.join(", ")}</dd></div>{/if}
    {#if event.promoters.length}<div><dt class="text-neutral-500">{japanese ? "主催・協力" : "Promoters"}</dt><dd class="mt-1 text-neutral-200">{event.promoters.join(", ")}</dd></div>{/if}
  </dl>
  {#if event.description}<p class="mt-5 text-sm leading-relaxed text-neutral-400">{event.description}</p>{/if}
  {#if event.work.length}
    <div class="mt-5">
      <h3 class="text-sm font-semibold text-neutral-300">{japanese ? "担当したこと" : "Our contribution"}</h3>
      <ul class="mt-3 space-y-3">
        {#each event.work as item (item.title)}
          <li><p class="text-sm font-medium">{item.title}</p><p class="mt-1 text-sm text-neutral-400">{item.body}</p></li>
        {/each}
      </ul>
    </div>
  {/if}
  {#if event.links.length}
    <ul class="mt-5 flex flex-wrap gap-4 text-sm">
      {#each event.links as link (link.url)}
        <li><a href={link.url} target="_blank" rel="noopener noreferrer" class="underline underline-offset-4">{link.label} ↗</a></li>
      {/each}
    </ul>
  {/if}
</section>
