const showAssets = import.meta.glob("./content/shows/*.{png,jpg,jpeg,webp,avif}", {
  eager: true,
  query: "?url",
  import: "default"
})

export function showAsset(filename) {
  const path = `./content/shows/${filename}`
  const asset = showAssets[path]
  if (!asset) throw new Error(`Missing show asset: ${path}`)
  return asset
}

export function formatShowDate(value, locale) {
  if (!value) return ""

  return new Intl.DateTimeFormat(locale, {
    dateStyle: "long",
    timeStyle: "short",
    timeZone: "Asia/Tokyo"
  }).format(new Date(value))
}

export function showUrl(slug, locale) {
  return locale === "en" ? `/en/shows/${slug}` : `/shows/${slug}`
}
