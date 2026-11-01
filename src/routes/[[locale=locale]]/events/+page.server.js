import { getPastEvents, pageMeta } from "~/contentData.server.js";

export function load({ params, url }) {
  const locale = params.locale ?? "ja";
  const title = locale === "ja" ? "過去のイベント" : "Past events";

  return {
    locale,
    events: getPastEvents(locale),
    meta: pageMeta({
      title: `${title} — Follow The Bass`,
      description:
        locale === "ja"
          ? "Follow The Bassがこれまでに開催したイベント。"
          : "Flyers and details from past Follow The Bass events.",
      locale,
      url
    })
  };
}
