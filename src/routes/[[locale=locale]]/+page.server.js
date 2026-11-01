import {
  getNewsForIndex,
  pageMeta
} from "~/contentData.server.js";

const TAGLINE = "Bass music promotion in Tokyo and beyond since 2014";

export function load({ params, url }) {
  const locale = params.locale ?? "ja";
  return {
    locale,
    news: getNewsForIndex(locale),
    meta: pageMeta({
      title: "Follow The Bass",
      description: TAGLINE,
      locale,
      url
    })
  };
}
