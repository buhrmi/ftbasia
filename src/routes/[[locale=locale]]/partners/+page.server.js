import { pageMeta } from "~/contentData.server.js";

export function load({ params, url }) {
  const locale = params.locale ?? "ja";
  const title = locale === "ja" ? "会場パートナー" : "Venue partnerships";

  return {
    locale,
    meta: pageMeta({
      title: `${title} — Follow The Bass`,
      description:
        locale === "ja"
          ? "会場オーナー・マネージャーの皆さまへ。Follow The Bassのイベント開催についてご相談ください。"
          : "Bring a Follow The Bass night to your venue. Get in touch to explore an event partnership.",
      locale,
      url
    })
  };
}
