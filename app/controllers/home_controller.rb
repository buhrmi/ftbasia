class HomeController < InertiaController
  def index
    upcoming = Event.includes(
      :venue,
      :event_promoters,
      :promoters,
      :event_artists,
      { event_artists: :artist },
      flyer_attachment: :blob
    ).select(&:upcoming?).sort_by(&:starts_at)
    articles = NewsArticle.published
      .includes(:translations, :artists, :events, cover_image_attachment: :blob)
      .limit(6)

    render inertia: {
      events: upcoming.map { |event| event_props(event) },
      news: articles.filter_map { |article| news_props(article) },
      meta: page_meta("Follow The Bass", "Bass music culture in Tokyo and beyond.", "/")
    }
  end
end
