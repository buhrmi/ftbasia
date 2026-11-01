import { error } from "@sveltejs/kit";
import { getNews, localizedPath, pageMeta } from "~/contentData.server.js";

export function load({ params, url }) {
  const locale = params.locale ?? "ja";
  const news = getNews(locale, params.slug);
  if (!news) error(404, "News article not found");

  return {
    locale,
    slug: news.slug,
    news,
    news_url: localizedPath(locale, "/news"),
    meta: pageMeta({
      title: news.title,
      description: news.description,
      type: "article",
      publishedAt: news.published_at,
      locale,
      url
    })
  };
}
