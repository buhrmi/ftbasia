class EventsController < InertiaController
  def index
    events = Event.includes(
      :venue,
      :event_promoters,
      :promoters,
      :event_artists,
      { event_artists: :artist },
      flyer_attachment: :blob
    ).to_a
    upcoming, past = events.partition(&:upcoming?)
    upcoming.sort_by!(&:starts_at)
    past.sort_by! { |event| event.starts_at || Time.at(0) }.reverse!

    render inertia: {
      upcoming_events: upcoming.map { |event| event_props(event) },
      past_events: past.map { |event| event_props(event) },
      meta: page_meta(
        I18n.locale == :ja ? "イベント" : "Events",
        I18n.locale == :ja ?
          "ベースミュージックイベントの予定とアーカイブ。" :
          "Upcoming bass music events and event archive.",
        "/events"
      )
    }
  end

  def show
    event = Event.includes(
      :venue,
      :event_promoters,
      :promoters,
      :event_artists,
      { event_artists: :artist },
      { news_articles: [:translations, :artists, :events, cover_image_attachment: :blob] },
      flyer_attachment: :blob
    ).find_by!(slug: params[:slug])
    articles = event.news_articles.published

    render inertia: {
      event: event_props(event),
      news: articles.filter_map { |article| news_props(article) },
      meta: page_meta(
        event.localized(:name, I18n.locale),
        event.localized(:bio, I18n.locale),
        "/events/#{event.slug}"
      )
    }
  end
end
