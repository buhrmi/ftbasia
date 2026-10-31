module NewsPresentation
  extend ActiveSupport::Concern

  private

  def news_props(news)
    {
      slug: news.slug,
      locale: news.locale,
      title: news.title,
      description: news.description,
      published_at: news.published_at&.iso8601,
      url: news_path(slug: news.slug, locale: prefixed_locale(news.locale)),
      tags: news.tags.map { |tag| tag_props(tag) }
    }
  end

  def tag_props(tag)
    url = case tag[:type]
    when "artist"
      artist_path(slug: tag[:slug], locale: prefixed_locale(I18n.locale))
    when "event"
      event_path(slug: tag[:slug], locale: prefixed_locale(I18n.locale))
    end

    tag.merge(url:)
  end

  def prefixed_locale(locale)
    locale.to_s == I18n.default_locale.to_s ? nil : locale
  end
end
