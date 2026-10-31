<script>
  import { profileImage } from "~/profiles.js";

  let { profile, locale, profileType, slug } = $props();

  const image = $derived(profileImage(profileType, slug));
  const linksHeading = $derived(locale === "ja" ? "公式リンク" : "Links");
  const sourcesHeading = $derived(locale === "ja" ? "参考情報" : "Sources");
  const interviewHeading = $derived(locale === "ja" ? "インタビュー" : "Interview");
</script>

<div class="flex items-center gap-5">
  {#if image}
    <img
      src={image}
      alt={profile.name}
      class="h-24 w-24 shrink-0 rounded-full object-cover"
    />
  {/if}
  <div>
    <h1 class="text-2xl font-semibold tracking-tight">{profile.name}</h1>
    {#if profile.role}
      <p class="mt-2 text-sm text-neutral-300">{profile.role}</p>
    {/if}
    {#if profile.location}
      <p class="mt-1 text-sm text-neutral-500">{profile.location}</p>
    {/if}
  </div>
</div>
{#if profile.tagline}
  <p class="mt-4 text-sm text-neutral-500">{profile.tagline}</p>
{/if}
{#if profile.bio}
  <p class="mt-4 max-w-3xl leading-relaxed text-neutral-300">{profile.bio}</p>
{/if}
{#if profile.links?.length}
  <section class="mt-8">
    <h2 class="mb-3 text-sm font-semibold text-neutral-300">{linksHeading}</h2>
    <ul class="flex flex-wrap gap-x-5 gap-y-2 text-sm">
      {#each profile.links as link (link.url)}
        <li>
          <a href={link.url} target="_blank" rel="noopener noreferrer" class="underline underline-offset-4">
            {link.label}
          </a>
        </li>
      {/each}
    </ul>
  </section>
{/if}
{#if profile.interview?.length}
  <section class="mt-10">
    <h2 class="mb-6 text-lg font-semibold">{interviewHeading}</h2>
    <ol class="grid gap-8">
      {#each profile.interview as entry, index (`${index}-${entry.question}`)}
        <li>
          <p class="text-[11px] tracking-[0.2em] text-neutral-500 tabular-nums">
            Q{String(index + 1).padStart(2, "0")}
          </p>
          <h3 class="mt-2 font-medium">{entry.question}</h3>
          <p class="mt-3 text-sm leading-7 text-neutral-400">{entry.answer}</p>
        </li>
      {/each}
    </ol>
  </section>
{/if}
{#if profile.sources?.length}
  <section class="mt-8">
    <h2 class="mb-3 text-sm font-semibold text-neutral-300">{sourcesHeading}</h2>
    <ul class="space-y-2 text-sm text-neutral-400">
      {#each profile.sources as source (source.url)}
        <li>
          <a href={source.url} target="_blank" rel="noopener noreferrer" class="underline underline-offset-4">
            {source.label}
          </a>
        </li>
      {/each}
    </ul>
  </section>
{/if}
