<script lang="ts">
  type Caption = { caption?: string };
  type MediaItem =
    | ({ kind: "tiktok"; video_id: string; alt: string } & Caption)
    | ({ kind: "video"; src: string; alt: string } & Caption)
    | ({ kind: "image"; src: string; width: number; height: number; alt: string } & Caption);

  let {
    items,
    label,
    fullscreenLabel,
    closeLabel,
    ofLabel,
    locale
  }: {
    items: MediaItem[];
    label: string;
    fullscreenLabel: string;
    closeLabel: string;
    ofLabel: string;
    locale: string;
  } = $props();

  let viewport = $state<HTMLDivElement | null>(null);
  let dialog = $state<HTMLDialogElement | null>(null);
  let current = $state(0);

  const count = $derived(items.length);
  const active = $derived(items[current]);

  function goTo(index: number) {
    const element = viewport;
    if (!element) return;
    const target = Math.min(Math.max(index, 0), count - 1);
    element.scrollTo({ left: target * element.clientWidth, behavior: "smooth" });
    current = target;
  }

  function onScroll() {
    const element = viewport;
    if (!element) return;
    current = Math.min(count - 1, Math.max(0, Math.round(element.scrollLeft / Math.max(1, element.clientWidth))));
  }

  function onKeydown(event: KeyboardEvent) {
    if (event.key === "ArrowLeft") {
      event.preventDefault();
      goTo(current - 1);
    } else if (event.key === "ArrowRight") {
      event.preventDefault();
      goTo(current + 1);
    }
  }

  function openFullscreen(index: number) {
    current = index;
    dialog?.showModal();
  }

  function closeOnBackdrop(event: MouseEvent) {
    if (event.target === dialog) dialog?.close();
  }

  function closeOnEscape(event: KeyboardEvent) {
    if (event.key === "Escape") {
      event.preventDefault();
      dialog?.close();
    }
  }

  const tiktokSrc = (id: string, autoplay = false) =>
    `https://www.tiktok.com/player/v1/${id}?music_info=1&description=1${autoplay ? "&autoplay=1&muted=1" : ""}`;
</script>

<div class="relative">
  <!-- svelte-ignore a11y_no_noninteractive_tabindex -->
  <!-- svelte-ignore a11y_no_noninteractive_element_interactions -->
  <div
    bind:this={viewport}
    onscroll={onScroll}
    onkeydown={onKeydown}
    tabindex="0"
    role="region"
    aria-roledescription="carousel"
    aria-label={label}
    class="flex snap-x snap-mandatory overflow-x-auto rounded-lg border border-white/10 bg-black [scrollbar-width:none] [&::-webkit-scrollbar]:hidden"
  >
    {#each items as item, index (index)}
      <div
        class="relative w-full shrink-0 snap-center"
        role="group"
        aria-roledescription="slide"
        aria-label="{index + 1} {ofLabel} {count}"
      >
        <div class="relative flex h-[min(64vh,520px)] w-full items-center justify-center overflow-hidden p-3 sm:p-4">
          {#if item.kind === "tiktok"}
            <iframe
              src={tiktokSrc(item.video_id)}
              title={item.alt}
              class="block h-full max-h-full w-auto max-w-full rounded border border-white/10"
              style="aspect-ratio: 325 / 578;"
              allow="encrypted-media; fullscreen; picture-in-picture"
              allowfullscreen
            ></iframe>
          {:else if item.kind === "video"}
            <!-- svelte-ignore a11y_media_has_caption -->
            <video
              src={item.src}
              controls
              playsinline
              preload="metadata"
              aria-label={item.alt}
              class="relative block max-h-full max-w-full rounded object-contain"
            ></video>
          {:else}
            <img
              src={item.src}
              alt=""
              aria-hidden="true"
              class="pointer-events-none absolute inset-0 h-full w-full scale-110 object-cover opacity-25 blur-2xl"
            />
            <img
              src={item.src}
              alt={item.alt}
              width={item.width}
              height={item.height}
              class="relative block max-h-full max-w-full rounded object-contain"
            />
          {/if}
        </div>

        <button
          type="button"
          onclick={() => openFullscreen(index)}
          class="absolute right-4 top-4 rounded-full border border-white/20 bg-black/60 px-3 py-1.5 text-[10px] tracking-[0.15em] text-neutral-200 uppercase backdrop-blur transition-colors hover:border-white/50 hover:text-white"
        >
          {fullscreenLabel}
        </button>
      </div>
    {/each}
  </div>

  {#if items.some((item) => item.caption)}
    <p class="mt-3 min-h-5 text-center text-xs leading-5 text-neutral-500">{active?.caption ?? ""}</p>
  {/if}

  {#if count > 1}
    <div class="mt-3 flex items-center justify-center gap-4">
      <button
        type="button"
        onclick={() => goTo(current - 1)}
        disabled={current === 0}
        aria-label={locale === "ja" ? "前へ" : "Previous"}
        class="rounded-full border border-white/15 px-3 py-1.5 text-[11px] text-neutral-400 transition-colors hover:border-white/40 hover:text-white disabled:opacity-30"
      >
        ←
      </button>
      <ul class="flex items-center gap-2">
        {#each items as item, index (index)}
          <li>
            <button
              type="button"
              onclick={() => goTo(index)}
              aria-label="{index + 1} {ofLabel} {count}"
              aria-current={current === index ? "true" : undefined}
              class="block h-1.5 rounded-full transition-all {current === index
                ? 'w-6 bg-white'
                : 'w-1.5 bg-white/30 hover:bg-white/60'}"
            ></button>
          </li>
        {/each}
      </ul>
      <button
        type="button"
        onclick={() => goTo(current + 1)}
        disabled={current === count - 1}
        aria-label={locale === "ja" ? "次へ" : "Next"}
        class="rounded-full border border-white/15 px-3 py-1.5 text-[11px] text-neutral-400 transition-colors hover:border-white/40 hover:text-white disabled:opacity-30"
      >
        →
      </button>
    </div>
  {/if}
</div>

<dialog
  bind:this={dialog}
  onclick={closeOnBackdrop}
  onkeydown={closeOnEscape}
  onclose={() => (current = 0)}
  class="fixed inset-0 m-0 h-full max-h-none w-full max-w-none border-0 bg-transparent p-0 backdrop:bg-black/90"
>
  <div class="pointer-events-none relative flex h-full items-center justify-center p-4">
    <button
      type="button"
      onclick={() => dialog?.close()}
      aria-label={closeLabel}
      class="pointer-events-auto absolute top-2 right-2 z-10 rounded-full border border-white/25 bg-black/70 px-3 py-1.5 text-[10px] tracking-[0.15em] text-neutral-200 uppercase transition-colors hover:border-white/60 hover:text-white"
    >
      {closeLabel}
    </button>

    {#each items as item, index (index)}
      {#if current === index}
        {#if item.kind === "tiktok"}
          <iframe
            src={tiktokSrc(item.video_id, true)}
            title={item.alt}
            class="pointer-events-auto block max-h-[88vh] w-auto max-w-full rounded"
            style="aspect-ratio: 325 / 578;"
            allow="encrypted-media; fullscreen; picture-in-picture"
            allowfullscreen
          ></iframe>
        {:else if item.kind === "video"}
          <!-- svelte-ignore a11y_media_has_caption -->
          <video
            src={item.src}
            controls
            playsinline
            preload="metadata"
            aria-label={item.alt}
            class="pointer-events-auto block max-h-[88vh] max-w-full rounded object-contain"
          ></video>
        {:else}
          <img
            src={item.src}
            alt={item.alt}
            class="pointer-events-auto block max-h-[88vh] w-auto max-w-full rounded object-contain"
          />
        {/if}
      {/if}
    {/each}
  </div>
</dialog>
