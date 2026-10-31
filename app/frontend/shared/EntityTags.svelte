<script>
  import { Link } from "inertiax-svelte";
  import { profileImage } from "~/profiles.js";

  let { tags, locale } = $props();
  const label = $derived(locale === "ja" ? "関連項目:" : "Tagged:");
</script>

{#if tags.length}
  <div class="mt-6 flex flex-wrap items-center gap-2 text-sm">
    <span class="text-neutral-500">{label}</span>
    {#each tags as tag (`${tag.type}-${tag.slug}`)}
      {@const image = profileImage(tag.type === "artist" ? "artists" : "events", tag.slug)}
      <Link
        href={tag.url}
        class="inline-flex items-center gap-2 rounded-full border border-white/15 py-1 pr-3 pl-1 text-neutral-300 hover:border-white/40 hover:text-white"
      >
        {#if image}
          <img src={image} alt="" class="h-7 w-7 rounded-full object-cover" />
        {/if}
        {tag.name}
      </Link>
    {/each}
  </div>
{/if}
