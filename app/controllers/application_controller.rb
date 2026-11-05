class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :set_locale

  inertia_share locale: -> { I18n.locale.to_s }
  inertia_share locale_switches: -> { locale_switches }

  private

  def set_locale
    requested_locale = params[:locale].presence ||
      (request.path.start_with?("/en/") || request.path == "/en" ? "en" : "ja")
    unless I18n.available_locales.map(&:to_s).include?(requested_locale)
      raise ActionController::RoutingError, "Not Found"
    end

    I18n.locale = requested_locale
  end

  def localized(value)
    return value unless value.is_a?(Hash)

    value[I18n.locale.to_s].presence || value["ja"].presence || value.values.find(&:present?)
  end

  def localized_path(path)
    return path if I18n.locale == :ja
    return "/en" if path == "/"

    "/en#{path}"
  end

  def locale_switches
    japanese_path = request.path.sub(%r{\A/en(?=/|\z)}, "").presence || "/"
    query = request.query_string.presence
    {
      ja: "#{japanese_path}#{query ? "?#{query}" : ""}",
      en: "#{japanese_path == "/" ? "/en" : "/en#{japanese_path}"}#{query ? "?#{query}" : ""}"
    }
  end

  def localized_record(record, attribute)
    record.localized(attribute, I18n.locale)
  end

  def attachment_props(attachment)
    return unless attachment&.attached?

    metadata = attachment.attachment
    {
      url: rails_blob_path(attachment, only_path: true),
      alt_text: localized(metadata.alt_text),
      caption: localized(metadata.caption),
      credit: metadata.credit,
      custom_metadata: metadata.custom_metadata
    }
  end

  def artist_props(artist)
    media = artist.remote_media.map do |item|
      {
        kind: item.fetch("provider"),
        video_id: item.fetch("video_id"),
        alt: localized(item["alt_text"]),
        caption: localized(item["caption"])
      }
    end
    media.concat(
      artist.media_attachments.includes(:blob).order(:position, :id).map do |attachment|
        metadata = attachment.custom_metadata || {}
        {
          kind: metadata["kind"].presence ||
            (attachment.blob.content_type&.start_with?("video/") ? "video" : "image"),
          url: rails_blob_path(attachment, only_path: true),
          alt: localized(attachment.alt_text),
          caption: localized(attachment.caption),
          width: metadata["width"],
          height: metadata["height"]
        }
      end
    )

    {
      slug: artist.slug,
      name: artist.display_name_for,
      role: localized_record(artist, :role),
      location: localized_record(artist, :location),
      tagline: localized_record(artist, :tagline),
      bio: localized_record(artist, :bio),
      links: artist.links,
      sources: artist.sources,
      avatar: attachment_props(artist.avatar),
      media: media,
      url: localized_path("/artists/#{artist.slug}")
    }
  end

  def event_props(event)
    {
      slug: event.slug,
      name: localized_record(event, :name),
      location: localized_record(event, :location),
      bio: localized_record(event, :bio),
      kind: localized_record(event, :kind),
      starts_at: event.starts_at&.iso8601,
      timezone: event.timezone,
      all_day: event.all_day?,
      description: localized_record(event, :description),
      work: localized(event.work) || [],
      performers: event.event_artists.map { |credit| credit.artist.display_name_for },
      artist_tags: event.artists.map do |artist|
        {
          type: "artist",
          slug: artist.slug,
          name: artist.display_name_for,
          url: localized_path("/artists/#{artist.slug}"),
          image: attachment_props(artist.avatar)
        }
      end,
      promoters: event.event_promoters.map { |credit| localized_record(credit.promoter, :name) },
      promoter_tags: event.promoters.map do |promoter|
        {
          type: "promoter",
          slug: promoter.slug,
          name: localized_record(promoter, :name)
        }
      end,
      venue: event.venue && {
        name: localized_record(event.venue, :name),
        location: localized_record(event.venue, :location)
      },
      links: event.links,
      flyer: attachment_props(event.flyer),
      url: localized_path("/events/#{event.slug}")
    }
  end

  def news_props(article)
    translation = article.translation(I18n.locale)
    return unless translation

    tags = article.artists.map do |artist|
      {
        type: "artist",
        slug: artist.slug,
        name: artist.display_name_for,
        url: localized_path("/artists/#{artist.slug}"),
        image: attachment_props(artist.avatar)
      }
    end
    tags.concat(article.events.map do |event|
      {
        type: "event",
        slug: event.slug,
        name: localized_record(event, :name),
        url: localized_path("/events/#{event.slug}"),
        image: attachment_props(event.flyer)
      }
    end)
    tags.concat(article.promoters.map do |promoter|
      {
        type: "promoter",
        slug: promoter.slug,
        name: localized_record(promoter, :name),
        url: localized_path("/promoters/#{promoter.slug}")
      }
    end)

    {
      slug: article.slug,
      category: article.category,
      published_at: article.published_at.iso8601,
      title: translation.title,
      description: translation.description,
      body_markdown: translation.body_markdown,
      cover_image: attachment_props(article.cover_image),
      tags: tags,
      embeds: article.embeds.map do |embed|
        {
          title: embed.title,
          url: embed.source_url,
          provider: embed.provider,
          height: embed.height
        }
      end,
      url: localized_path("/news/#{article.slug}")
    }
  end

  def page_meta(title, description, path, article: nil)
    canonical_path = localized_path(path)
    {
      title: "#{title} — Follow The Bass",
      description: description,
      canonical_url: "#{request.base_url}#{canonical_path}",
      image_url: article&.cover_image&.attached? ?
        "#{request.base_url}#{rails_blob_path(article.cover_image, only_path: true)}" : nil,
      published_at: article&.published_at&.iso8601
    }
  end
end
