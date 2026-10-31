const profileAssets = import.meta.glob("./content/{artists,events}/*.{png,jpg,jpeg,webp,avif,mp4}", {
  eager: true,
  query: "?url",
  import: "default"
})

export function profileImage(type, slug) {
  const prefix = `./content/${type}/${slug}.`
  const imagePath = Object.keys(profileAssets)
    .filter((path) => path.startsWith(prefix))
    .sort((a, b) => {
      const priority = [".png", ".jpg", ".jpeg", ".webp", ".avif"]
      return priority.indexOf(a.slice(prefix.length - 1)) - priority.indexOf(b.slice(prefix.length - 1))
    })[0]

  return imagePath ? profileAssets[imagePath] : undefined
}

export function profileAsset(type, filename) {
  const path = `./content/${type}/${filename}`
  const asset = profileAssets[path]
  if (!asset) throw new Error(`Missing profile asset: ${path}`)
  return asset
}
