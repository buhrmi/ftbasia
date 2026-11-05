<script>
  import { Link } from "@inertiajs/svelte";

  let { locale = "ja", localeSwitches, children } = $props();
  const japanese = $derived(locale === "ja");
  const links = $derived(japanese
    ? [
        { href: "/artists", label: "アーティスト" },
        { href: "/events", label: "イベント" },
        { href: "/news", label: "ニュース" }
      ]
    : [
        { href: "/en/artists", label: "Artists" },
        { href: "/en/events", label: "Events" },
        { href: "/en/news", label: "News" }
      ]);
</script>

<header class="site-header">
  <div class="site-header-inner">
    <Link class="site-brand" href={japanese ? "/" : "/en"} aria-label="Follow The Bass">
      <span class="site-brand__copy">
        <span class="site-brand__name">Follow The Bass</span>
        <span class="site-brand__caption">Bass culture · Tokyo &amp; beyond</span>
      </span>
    </Link>
    <nav class="site-nav" aria-label={japanese ? "メインナビゲーション" : "Main navigation"}>
      {#each links as item (item.href)}
        <Link href={item.href}>{item.label}</Link>
      {/each}
      <div class="language-toggle" role="group" aria-label={japanese ? "言語を選択" : "Select language"}>
        <Link href={localeSwitches?.ja ?? "/"} lang="ja" aria-current={japanese ? "page" : undefined}>JA</Link>
        <Link href={localeSwitches?.en ?? "/en"} lang="en" aria-current={!japanese ? "page" : undefined}>EN</Link>
      </div>
    </nav>
  </div>
</header>

{@render children()}

<footer class="site-footer">
  <section class="site-footer__cta">
    <div>
      <p>{japanese ? "会場オーナー・マネージャーの皆さまへ" : "For venue owners and managers"}</p>
      <h2>{japanese ? "Follow The Bassのイベントを開催しませんか？" : "Host a Follow The Bass night"}</h2>
    </div>
    <Link href={japanese ? "/partners" : "/en/partners"}>
      {japanese ? "パートナーについて" : "Explore venue partnerships"} <span aria-hidden="true">→</span>
    </Link>
  </section>
  <div class="flex flex-wrap items-center justify-between gap-4 border-t border-white/10 py-6">
    <a class="text-xs text-neutral-500 underline underline-offset-4" href="https://github.com/buhrmi/ftbasia">
      {japanese ? "Follow The Bassのウェブサイトはオープンソースです。" : "The Follow The Bass website is open source."}
    </a>
    <p class="text-[11px] tracking-[0.25em] text-neutral-500 uppercase">&copy; Follow The Bass</p>
  </div>
</footer>
