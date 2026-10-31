require "time"

class Show
  CONTENT_DIR = Rails.root.join("app/frontend/content/shows")
  SLUG_PATTERN = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

  attr_reader :slug, :event_slug, :starts_at, :flyer, :links

  class << self
    def find(slug)
      return unless SLUG_PATTERN.match?(slug.to_s)

      path = CONTENT_DIR.join("#{slug}.yml")
      new(slug, YAML.safe_load_file(path)) if File.file?(path)
    end

    def for_event(event_slug)
      Dir.glob(CONTENT_DIR.join("*.yml"))
        .filter_map { |path| new(File.basename(path, ".yml"), YAML.safe_load_file(path)) }
        .select { |show| show.event_slug == event_slug.to_s }
        .sort_by(&:starts_at)
    end
  end

  def initialize(slug, data)
    @slug = slug
    @event_slug = data.fetch("event").to_s
    raise ArgumentError, "Show event cannot be blank: #{slug}" if @event_slug.blank?

    @name = data.fetch("name")
    @kind = data["kind"]
    @location = data["location"]
    @description = data.fetch("description", {})
    @performers = data.fetch("performers", {})
    @work = data.fetch("work", {})
    @flyer = data["flyer"].to_s.presence
    @starts_at = parse_time(data.fetch("starts_at"))
    @links = parse_links(data)

    raise ArgumentError, "Show description must be localized text: #{slug}" unless @description.is_a?(Hash)
    raise ArgumentError, "Show performers must be localized entries: #{slug}" unless @performers.is_a?(Hash)
    raise ArgumentError, "Show work must be localized entries: #{slug}" unless @work.is_a?(Hash)
  end

  def event
    @event ||= Event.find(event_slug)
  end

  def name(locale:)
    localized_text(@name, locale:)
  end

  def description(locale:)
    localized_text(@description, locale:)
  end

  def to_props(locale:)
    {
      slug: slug,
      event_slug: event_slug,
      name: name(locale:),
      kind: localized_text(@kind, locale:),
      starts_at: starts_at.iso8601,
      year: starts_at.year,
      location: localized_text(@location, locale:),
      description: description(locale:),
      performers: localized_list(@performers, locale:),
      work: work(locale:),
      links: links,
      flyer: flyer
    }.compact
  end

  private

  def parse_time(value)
    Time.iso8601(value.to_s)
  rescue ArgumentError
    raise ArgumentError, "Invalid show start time: #{slug}"
  end

  def localized_text(value, locale:)
    return value.to_s.presence unless value.is_a?(Hash)

    value[locale.to_s].presence || value[I18n.default_locale.to_s].presence || value.values.first.to_s.presence
  end

  def localized_list(value, locale:)
    entries = value[locale.to_s] || value[I18n.default_locale.to_s] || value.values.first
    Array(entries).map(&:to_s)
  end

  def work(locale:)
    entries = @work[locale.to_s] || @work[I18n.default_locale.to_s] || @work.values.first
    Array(entries).map do |entry|
      raise ArgumentError, "Invalid work entry in show #{slug}" unless entry.is_a?(Hash)

      title = entry.fetch("title").to_s
      body = entry.fetch("body").to_s
      raise ArgumentError, "Invalid work entry in show #{slug}" if title.blank? || body.blank?

      { title:, body: }
    end
  end

  def parse_links(data)
    Array(data["links"]).map do |entry|
      raise ArgumentError, "Invalid links entry in show #{slug}" unless entry.is_a?(Hash)

      label = entry.fetch("label").to_s
      url = entry.fetch("url").to_s
      raise ArgumentError, "Invalid links entry in show #{slug}" if label.blank? || url.blank?

      { label:, url: }
    end
  end
end
