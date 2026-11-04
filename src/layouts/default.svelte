<script>
  import { page } from "$app/state";
  import Footer from "~/shared/Footer.svelte";

  let { children, data } = $props();

  const SITE_NAME = "Follow The Bass";
  const locale = $derived(data.locale);
  const localePrefix = $derived(locale === "en" ? "/en" : "");
  const unlocalizedPath = $derived(page.url.pathname.replace(/^\/en(?=\/|$)/, "") || "/");
  const japaneseHref = $derived(`${unlocalizedPath}${page.url.search}${page.url.hash}`);
  const englishHref = $derived(
    `/en${unlocalizedPath === "/" ? "" : unlocalizedPath}${page.url.search}${page.url.hash}`
  );
</script>

<header class="site-header">
  <div class="site-header-inner">
    <a class="site-brand" href={locale === "en" ? "/en" : "/"} aria-label={SITE_NAME}>
      <span class="site-brand__copy">
        <span class="site-brand__name">Follow The Bass</span>
        <span class="site-brand__caption">Bass culture · Tokyo &amp; beyond</span>
      </span>
    </a>
    <nav class="site-nav" aria-label={locale === "ja" ? "メインナビゲーション" : "Main navigation"}>
      <a href={`${localePrefix}/artists`}>{locale === "ja" ? "アーティスト" : "Artists"}</a>
      <a href={`${localePrefix}/news`}>{locale === "ja" ? "ニュース" : "News"}</a>
      <div
        class="language-toggle"
        role="group"
        aria-label={locale === "ja" ? "言語を選択" : "Select language"}
      >
        <a
          href={japaneseHref}
          lang="ja"
          aria-current={locale === "ja" ? "page" : undefined}
          class:language-toggle__active={locale === "ja"}
        >JA</a>
        <a
          href={englishHref}
          lang="en"
          aria-current={locale === "en" ? "page" : undefined}
          class:language-toggle__active={locale === "en"}
        >EN</a>
      </div>
    </nav>
  </div>
</header>

{@render children()}

<Footer {locale} />

<style>
  .site-header {
    position: sticky;
    top: 0;
    z-index: 50;
    width: 100vw;
    margin-inline: calc(50% - 50vw);
    border-bottom: 1px solid rgb(255 255 255 / 8%);
    background: rgb(8 8 8 / 88%);
    backdrop-filter: blur(12px);
    margin-bottom: 0.75rem;
  }

  .site-header-inner {
    display: flex;
    width: 100%;
    max-width: 79rem;
    min-height: 5.25rem;
    margin-inline: auto;
    align-items: center;
    justify-content: space-between;
    gap: 1rem;
    padding: 0.75rem 1.5rem;
  }

  .site-brand {
    display: inline-flex;
    min-width: 0;
    align-items: center;
    color: inherit;
    text-decoration: none;
  }

  .site-brand:focus-visible,
  .site-nav a:focus-visible {
    outline: 2px solid white;
    outline-offset: 4px;
  }

  .site-brand__copy {
    display: flex;
    min-width: 0;
    flex-direction: column;
    gap: 0.15rem;
  }

  .site-brand__name {
    overflow: hidden;
    font-size: 0.95rem;
    font-weight: 700;
    letter-spacing: 0.12em;
    line-height: 1.2;
    text-overflow: ellipsis;
    text-transform: uppercase;
    white-space: nowrap;
  }

  .site-brand__caption {
    color: #a3a3a3;
    font-size: 0.65rem;
    letter-spacing: 0.035em;
    white-space: nowrap;
  }

  .site-nav {
    display: flex;
    flex: 0 0 auto;
    align-items: center;
    gap: clamp(0.75rem, 3vw, 1.5rem);
  }

  .site-nav a {
    color: #a3a3a3;
    font-size: 0.65rem;
    font-weight: 600;
    letter-spacing: 0.16em;
    text-decoration: none;
    text-transform: uppercase;
    transition: color 160ms ease;
  }

  .site-nav a:hover {
    color: white;
  }

  .language-toggle {
    display: inline-flex;
    align-items: center;
    gap: 0.1rem;
    border: 1px solid rgb(255 255 255 / 12%);
    border-radius: 9999px;
    padding: 0.15rem;
  }

  .site-nav .language-toggle a {
    border-radius: 9999px;
    padding: 0.35rem 0.45rem;
    color: #a3a3a3;
    font-size: 0.6rem;
    letter-spacing: 0.06em;
    line-height: 1;
  }

  .site-nav .language-toggle a.language-toggle__active {
    background: rgb(255 255 255 / 12%);
    color: white;
  }

  .site-nav .language-toggle a:focus-visible {
    outline-offset: 2px;
  }

  @media (max-width: 420px) {
    .site-header-inner {
      padding-inline: 1.25rem;
    }

    .site-brand__name {
      font-size: 0.8rem;
      letter-spacing: 0.08em;
    }

    .site-brand__caption {
      font-size: 0.58rem;
    }

    .site-nav {
      gap: 0.65rem;
    }

    .site-nav a {
      font-size: 0.58rem;
      letter-spacing: 0.1em;
    }
  }

  @media (max-width: 380px) {
    .site-header-inner {
      padding-inline: 1rem;
    }
  }
</style>