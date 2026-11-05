require "json"
require "stringio"
require "uri"

SEED_DATA = JSON.parse(Rails.root.join("db/seeds/content.json").read)

def seed_attachment(record, name, data, collection: false)
  return unless data

  asset_path = Rails.root.join(data.fetch("path"))
  raise "Missing seed asset: #{asset_path}" unless asset_path.file?

  association = record.public_send(name)
  seed_path = data.fetch("path")
  attachments = record.public_send("#{name}_attachments") if collection
  current = if collection
    attachments.find do |attachment|
      attachment.custom_metadata["seed_path"] == seed_path ||
        attachment.blob.filename.to_s == asset_path.basename.to_s
    end
  else
    record.public_send("#{name}_attachment")
  end

  unless current&.blob&.service&.exist?(current.blob.key)
    content = File.binread(asset_path)
    blob = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(content),
      filename: asset_path.basename.to_s,
      content_type: Marcel::MimeType.for(content, name: asset_path.basename.to_s)
    )
    association.attach(blob)
    current&.destroy! if collection
    current = if collection
      record.public_send("#{name}_attachments").order(:id).last
    else
      record.public_send("#{name}_attachment")
    end
  end

  current.update!(
    alt_text: data.fetch("alt_text", {}),
    caption: data.fetch("caption", {}),
    credit: data["credit"],
    position: data.fetch("position", 0),
    custom_metadata: data.fetch("custom_metadata", {}).merge(
      "seed_path" => seed_path,
      "kind" => data["kind"]
    ).compact
  )
end

def event_start_time(raw, timezone)
  return if raw.blank?

  Time.use_zone(timezone) { Time.zone.parse(raw) }
end

ActiveRecord::Base.transaction do
  SEED_DATA.fetch("artists").each do |data|
    artist = Artist.find_or_initialize_by(slug: data.fetch("slug"))
    artist.update!(
      data.slice(
        "name", "display_name", "role", "location", "tagline", "bio", "links", "sources",
        "remote_media", "featured"
      )
    )
    seed_attachment(artist, "avatar", data["avatar"])
    data.fetch("media", []).each do |media|
      seed_attachment(artist, "media", media, collection: true)
    end
  end

  SEED_DATA.fetch("promoters").each do |data|
    Promoter.find_or_initialize_by(slug: data.fetch("slug")).update!(
      data.slice("name", "description", "links")
    )
  end

  SEED_DATA.fetch("venues").each do |data|
    Venue.find_or_initialize_by(slug: data.fetch("slug")).update!(
      data.slice("name", "location", "links")
    )
  end

  SEED_DATA.fetch("events").each do |data|
    event = Event.find_or_initialize_by(slug: data.fetch("slug"))
    event.update!(
      data.slice("name", "location", "bio", "kind", "timezone", "all_day", "description", "work", "links")
        .merge(
          starts_at: event_start_time(data["starts_at"], data.fetch("timezone")),
          venue: data["venue_slug"] && Venue.find_by!(slug: data.fetch("venue_slug"))
        )
    )
    seed_attachment(event, "flyer", data["flyer"])

    event.event_artists.delete_all
    Array(data.fetch("performers", {}).fetch("en", [])).reject(&:blank?).each_with_index do |name, position|
      artist = Artist.find_by!(name:)
      event.event_artists.create!(artist:, position:)
    end
    event.event_promoters.delete_all
    data.fetch("promoter_slugs", []).each_with_index do |slug, position|
      event.event_promoters.create!(promoter: Promoter.find_by!(slug:), position:)
    end
  end

  SEED_DATA.fetch("news").each do |data|
    article = NewsArticle.find_or_initialize_by(slug: data.fetch("slug"))
    article.update!(category: data.fetch("category"), published_at: Date.parse(data.fetch("published_at")))
    seed_attachment(article, "cover_image", data["cover_image"])

    data.fetch("translations").each do |translation|
      article.translations.find_or_initialize_by(locale: translation.fetch("locale")).update!(
        translation.slice("title", "description", "body_markdown")
      )
    end

    article.news_artists.delete_all
    data.fetch("artist_slugs", []).each do |slug|
      article.news_artists.create!(artist: Artist.find_by!(slug:))
    end
    article.news_events.delete_all
    data.fetch("event_slugs", []).each do |slug|
      article.news_events.create!(event: Event.find_by!(slug:))
    end
    article.embeds.delete_all
    data.fetch("translations").flat_map { |translation| translation.fetch("embeds", []) }
      .uniq { |embed| embed.fetch("url") }
      .each_with_index do |embed, position|
        host = URI.parse(embed.fetch("url")).host
        provider = {
          "w.soundcloud.com" => "soundcloud",
          "www.youtube.com" => "youtube",
          "www.instagram.com" => "instagram"
        }.fetch(host)
        article.embeds.create!(
          title: embed.fetch("title"),
          source_url: embed.fetch("url"),
          provider:,
          height: embed.fetch("height"),
          position:
        )
      end
  end
end

puts "Seeded #{Artist.count} artists, #{Promoter.count} promoters, #{Venue.count} venues, #{Event.count} events, and #{NewsArticle.count} news articles."
