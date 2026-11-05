<script>
  let { items = [], locale = "en" } = $props();
  const heading = $derived(locale === "ja" ? "写真・動画" : "Photos and videos");

  function tiktokSrc(id) {
    return `https://www.tiktok.com/player/v1/${encodeURIComponent(id)}?music_info=1&description=1`;
  }
</script>

{#if items.length}
  <section class="mb-10" aria-label={heading}>
    <h2 class="mb-4 text-lg font-semibold">{heading}</h2>
    <ul class="grid gap-5">
      {#each items as item, index (index)}
        <li class="overflow-hidden rounded-lg border border-white/10 bg-black">
          <div class="flex min-h-64 items-center justify-center bg-neutral-950 p-3">
            {#if item.kind === "tiktok"}
              <iframe
                src={tiktokSrc(item.video_id)}
                title={item.alt}
                class="h-[min(64vh,520px)] w-full max-w-[325px] rounded"
                allow="encrypted-media; fullscreen; picture-in-picture"
                allowfullscreen
              ></iframe>
            {:else if item.kind === "video"}
              <!-- svelte-ignore a11y_media_has_caption -->
              <video src={item.url} controls playsinline preload="metadata" aria-label={item.alt} class="max-h-[64vh] max-w-full rounded object-contain"></video>
            {:else}
              <img src={item.url} alt={item.alt ?? item.caption ?? ""} width={item.width} height={item.height} loading="lazy" class="max-h-[64vh] max-w-full rounded object-contain" />
            {/if}
          </div>
          {#if item.caption}<p class="p-3 text-center text-xs text-neutral-500">{item.caption}</p>{/if}
        </li>
      {/each}
    </ul>
  </section>
{/if}
