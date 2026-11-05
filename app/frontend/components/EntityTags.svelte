<script>
  import { Link } from "@inertiajs/svelte";

  let { tags = [], locale = "en" } = $props();
</script>

{#if tags.length}
  <div class="mt-6 flex flex-wrap items-center gap-2 text-sm">
    <span class="text-neutral-500">{locale === "ja" ? "関連項目:" : "Tagged:"}</span>
    {#each tags as tag (`${tag.type}-${tag.slug}`)}
      {#if tag.url}
        <Link href={tag.url} class="inline-flex items-center gap-2 rounded-full border border-white/15 py-1 pr-3 pl-1 text-neutral-300 hover:border-white/40 hover:text-white">
          {#if tag.image?.url}
            <img src={tag.image.url} alt="" class="h-7 w-7 rounded-full object-cover" loading="lazy" />
          {/if}
          {tag.name}
        </Link>
      {:else}
        <span class="inline-flex items-center gap-2 rounded-full border border-white/15 py-1 pr-3 pl-1 text-neutral-300">
          {#if tag.image?.url}
            <img src={tag.image.url} alt="" class="h-7 w-7 rounded-full object-cover" loading="lazy" />
          {/if}
          {tag.name}
        </span>
      {/if}
    {/each}
  </div>
{/if}
