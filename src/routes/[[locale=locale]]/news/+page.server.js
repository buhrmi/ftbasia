import { pageMeta, getNewsForIndex, localizedNewsIndexMeta } from "~/contentData.server.js";

export function load({ params, url }) {
  const locale = params.locale ?? "ja";
  return {
    locale,
    news: getNewsForIndex(locale),
    meta: pageMeta({ ...localizedNewsIndexMeta(locale), locale, url })
  };
}
