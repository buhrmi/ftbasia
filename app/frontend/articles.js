// Markdown articles are compiled to Svelte components by mdsvex at build time.
// Files live at app/frontend/content/articles/<slug>/<locale>.md, with an optional
// preview image (og.png, `<locale>.png`, …) next to them for social sharing.
const articles = import.meta.glob("./content/articles/*/*.md", { eager: true })
const images = import.meta.glob("./content/articles/*/*.{png,jpg,jpeg,webp,avif}", {
  eager: true,
  query: "?url",
  import: "default"
})

export function articleComponent(locale, slug) {
  return articles[`./content/articles/${slug}/${locale}.md`]?.default
}

export function articleImage(slug, locale) {
  const prefix = `./content/articles/${slug}/`
  const candidates = Object.entries(images).filter(([path]) => path.startsWith(prefix))
  const preferred =
    candidates.find(([path]) => /\/og\.(png|jpe?g|webp|avif)$/.test(path)) ??
    candidates.find(([path]) => new RegExp(`/${locale}\\.(png|jpe?g|webp|avif)$`).test(path)) ??
    candidates[0]

  return preferred?.[1]
}

export function absoluteUrl(path, origin) {
  if (!path) return undefined

  return /^https?:\/\//.test(path) ? path : `${origin}${path}`
}

export function formatArticleDate(value, locale) {
  if (!value) return ""

  return new Intl.DateTimeFormat(locale, { dateStyle: "long", timeZone: "UTC" }).format(new Date(value))
}
