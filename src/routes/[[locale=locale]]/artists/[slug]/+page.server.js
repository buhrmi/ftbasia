import { error } from "@sveltejs/kit";
import { getProfile, getTaggedNews, pageMeta } from "~/contentData.server.js";

export function load({ params, url }) {
  const locale = params.locale ?? "ja";
  const profile = getProfile("artist", params.slug, locale);
  if (!profile) error(404, "Artist not found");

  return {
    locale,
    profile,
    news: getTaggedNews("artist", profile.slug, locale),
    meta: pageMeta({
      title: profile.name,
      description: profile.bio,
      locale,
      url
    })
  };
}
