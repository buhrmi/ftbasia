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
          ? "Follow The Bassで紹介するベースミュージックのアーティスト。"
          : "Artists featured on Follow The Bass, with profiles and information about their work.",
      locale,
      url
    })
  };
}
