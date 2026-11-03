import { getArtistIndex, pageMeta } from "~/contentData.server.js";

export function load({ params, url }) {
  const locale = params.locale ?? "ja";
  const title = locale === "ja" ? "アーティスト" : "Artists";

  return {
    locale,
    artists: getArtistIndex(locale),
    meta: pageMeta({
      title: `${title} — Follow The Bass`,
      description:
        locale === "ja"
          ? "Follow The Bassとともにベースミュージックを届けるアーティスト。"
          : "Meet the artists bringing bass music to life with Follow The Bass.",
      locale,
      url
    })
  };
}
