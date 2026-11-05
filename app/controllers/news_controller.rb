class NewsController < InertiaController
  def index
    articles = NewsArticle.published
      .includes(:translations, :artists, :events, cover_image_attachment: :blob)

    render inertia: {
      news: articles.filter_map { |article| news_props(article) },
      meta: page_meta(
        I18n.locale == :ja ? "ニュース" : "News",
        I18n.locale == :ja ?
          "Follow The Bassからのお知らせ、アーティスト、ベースミュージックのストーリー。" :
          "Announcements, artist stories and news from Follow The Bass.",
        "/news"
      )
    }
  end

  def show
    article = NewsArticle.includes(
      :translations,
      :artists,
      :events,
      :promoters,
      :embeds,
      cover_image_attachment: :blob
    ).find_by!(slug: params[:slug])
    translation = article.translation(I18n.locale)
    raise ActionController::RoutingError, "Not Found" unless translation

    render inertia: {
      news: news_props(article),
      meta: page_meta(
        translation.title,
        translation.description,
        "/news/#{article.slug}",
        article:
      )
    }
  end
end
