class Profile
  SLUG_PATTERN = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/

  attr_reader :slug, :name, :links, :sources

  class << self
    def find(slug)
      return unless SLUG_PATTERN.match?(slug.to_s)

      path = content_dir.join("#{slug}.yml")
      new(slug, YAML.safe_load_file(path)) if File.file?(path)
    end

    private

    def content_dir
      const_get(:CONTENT_DIR)
    end
  end

  def initialize(slug, data)
    @slug = slug
    @name = data.fetch("name").to_s
    raise ArgumentError, "Profile name cannot be blank: #{slug}" if @name.blank?

    @role = data["role"]
    @location = data["location"]
    @tagline = data["tagline"]
    @bio = data.fetch("bio", {})
    raise ArgumentError, "Profile bio must be localized text: #{slug}" unless @bio.is_a?(Hash)

    @interview = data.fetch("interview", {})
    raise ArgumentError, "Profile interview must be localized entries: #{slug}" unless @interview.is_a?(Hash)

    @media = data.fetch("media", [])
    raise ArgumentError, "Profile media must be a list: #{slug}" unless @media.is_a?(Array)

    [ @role, @location, @tagline ].compact.each do |value|
      unless value.is_a?(String) || value.is_a?(Hash)
        raise ArgumentError, "Profile text must be a string or localized text: #{slug}"
      end
    end

    @links = profile_links(data, "links")
    @sources = profile_links(data, "sources")
  end

  def bio(locale:)
    localized_text(@bio, locale:)
  end

  def to_props(locale:)
    {
      slug: slug,
      name: name,
      role: localized_text(@role, locale:),
      location: localized_text(@location, locale:),
      tagline: localized_text(@tagline, locale:),
      bio: bio(locale:),
      links: links,
      sources: sources,
      interview: interview(locale:).presence,
      media: media(locale:).presence
    }.compact
  end

  def tagged_news(locale:)
    News.all_for_index(locale:).select { |item| item.tagged?(self.class::TAG_TYPE, slug) }
  end

  private

  def localized_text(value, locale:)
    return value.to_s.presence unless value.is_a?(Hash)

    value[locale.to_s].presence || value[I18n.default_locale.to_s].presence || value.values.first.to_s.presence
  end

  def interview(locale:)
    entries = localized_entries(@interview, locale:)
    return [] if entries.nil?
    raise ArgumentError, "Profile interview entries must be a list: #{slug}" unless entries.is_a?(Array)

    entries.map do |entry|
      unless entry.is_a?(Hash) && entry["question"].present? && entry["answer"].present?
        raise ArgumentError, "Invalid interview entry in profile #{slug}"
      end

      { question: entry["question"].to_s, answer: entry["answer"].to_s }
    end
  end

  def media(locale:)
    @media.map do |item|
      raise ArgumentError, "Invalid media entry in profile #{slug}" unless item.is_a?(Hash)

      kind = item.fetch("kind").to_s
      raise ArgumentError, "Invalid media kind in profile #{slug}" unless %w[tiktok video image].include?(kind)

      alt = localized_text(item["alt"], locale:)
      raise ArgumentError, "Media alt text cannot be blank in profile #{slug}" if alt.blank?

      entry = { kind:, alt: }
      caption = localized_text(item["caption"], locale:)
      entry[:caption] = caption if caption.present?

      case kind
      when "tiktok"
        video_id = item.fetch("video_id").to_s
        raise ArgumentError, "Invalid TikTok video ID in profile #{slug}" if video_id.blank?

        entry[:video_id] = video_id
      when "video", "image"
        asset = item.fetch("asset").to_s
        raise ArgumentError, "Invalid media asset in profile #{slug}" if asset.blank?

        entry[:asset] = asset
      end

      if kind == "image"
        entry[:width] = Integer(item.fetch("width"))
        entry[:height] = Integer(item.fetch("height"))
      end

      entry
    end
  end

  def localized_entries(value, locale:)
    return if value.empty?

    value[locale.to_s] || value[I18n.default_locale.to_s] || value.values.first
  end

  def profile_links(data, key)
    Array(data[key]).map do |entry|
      raise ArgumentError, "Invalid #{key} entry in profile #{slug}" unless entry.is_a?(Hash)

      label = entry.fetch("label").to_s
      url = entry.fetch("url").to_s
      raise ArgumentError, "Invalid #{key} entry in profile #{slug}" if label.blank? || url.blank?

      { label:, url: }
    end
  end
end
