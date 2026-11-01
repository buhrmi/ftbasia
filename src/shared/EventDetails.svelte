<script>
  import { profileAsset } from "~/profiles.js";

  let { profile, locale } = $props();

  const flyer = $derived(
    profile.flyer ? profileAsset("events", profile.flyer) : undefined
  );
  const date = $derived(
    profile.starts_at
      ? new Intl.DateTimeFormat(locale, {
          dateStyle: "long",
          timeStyle: "short",
          timeZone: "Asia/Tokyo"
        }).format(new Date(profile.starts_at))
      : undefined
  );
  const heading = $derived(locale === "ja" ? "イベント詳細" : "Event details");
  const workHeading = $derived(locale === "ja" ? "担当したこと" : "Our contribution");
  const performerLabel = $derived(locale === "ja" ? "出演" : "Performers");
</script>

{#if date || profile.description || profile.performers?.length || profile.work?.length || flyer}
  <section class="mt-12 border-t border-white/10 pt-8">
    <h2 class="text-lg font-semibold">{heading}</h2>
    <div class="mt-6 flex flex-col gap-6 sm:flex-row sm:items-start">
      {#if flyer}
        <img
          src={flyer}
          alt={`${profile.name} flyer`}
          width="750"
          height="750"
          loading="lazy"
          class="block w-full shrink-0 rounded-lg border border-white/10 sm:w-52"
        />
      {/if}
      <div class="min-w-0">
        {#if date || profile.kind}
          <p class="text-sm text-neutral-500">
            {#if date}<time datetime={profile.starts_at}>{date}</time>{/if}
            {#if date && profile.kind}{" · "}{/if}
            {profile.kind}
          </p>
        {/if}
        {#if profile.description}
          <p class="mt-3 text-sm leading-relaxed text-neutral-400">{profile.description}</p>
        {/if}
        {#if profile.performers?.length}
          <p class="mt-3 text-sm text-neutral-300">
            <span class="text-neutral-500">{performerLabel}:</span>
            {profile.performers.join(", ")}
          </p>
        {/if}
        {#if profile.work?.length}
          <div class="mt-5">
            <p class="text-[11px] tracking-[0.2em] text-neutral-500 uppercase">{workHeading}</p>
            <ul class="mt-2 space-y-3">
              {#each profile.work as item (item.title)}
                <li>
                  <p class="text-sm font-medium text-neutral-200">{item.title}</p>
                  <p class="mt-1 text-sm leading-relaxed text-neutral-400">{item.body}</p>
                </li>
              {/each}
            </ul>
          </div>
        {/if}
      </div>
    </div>
  </section>
{/if}
