class News
  CONTENT_DIR = Rails.root.join("app/frontend/content/news")
  SLUG_PATTERN = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/
  FRONT_MATTER = /\A---\s*\n(.*?)\n---\s*\n/m

  attr_reader :slug, :locale, :title, :description, :published_at

  class << self
    def all(locale:)
      Dir.glob(CONTENT_DIR.join("*", "#{locale}.md"))
        .filter_map { |path| new(path) }
        .sort_by { |news| news.published_at || Date.new(1970, 1, 1) }
        .reverse
    end

    def all_for_index(locale:)
      Dir.glob(CONTENT_DIR.join("*", "*.md"))
        .sort
        .map { |path| new(path) }
        .group_by(&:slug)
        .values
        .map { |translations| translations.find { |news| news.locale == locale.to_s } || translations.first }
        .sort_by { |news| news.published_at || Date.new(1970, 1, 1) }
        .reverse
    end

    def find(locale:, slug:)
      return unless SLUG_PATTERN.match?(slug.to_s)

      path = CONTENT_DIR.join(slug, "#{locale}.md")
      new(path) if File.file?(path)
    end
  end

  def initialize(path)
    path = Pathname(path)
    @slug = path.parent.basename.to_s
    @locale = path.basename(".md").to_s

    data = front_matter(path.read)
    @title = data["title"].to_s
    @description = data["description"].to_s
    @published_at = parse_date(data["published_at"] || data["created_at"])
    @tag_data = data["tags"]
  end

  def tags
    @tags ||= Array(@tag_data).map do |tag|
      raise ArgumentError, "Invalid news tag in #{slug}" unless tag.is_a?(Hash)

      type = tag.fetch("type")
      slug = tag.fetch("slug")
      entity_class = { "artist" => Artist, "event" => Event }.fetch(type) do
        raise ArgumentError, "Unknown news tag type: #{type}"
      end
      entity = entity_class.find(slug)
      raise ArgumentError, "Unknown #{type} tag: #{slug}" unless entity

      { type: type, slug: entity.slug, name: entity.name }
    end
  end

  def tagged?(type, slug)
    tags.any? { |tag| tag[:type] == type && tag[:slug] == slug }
  end

  private

  def front_matter(contents)
    match = FRONT_MATTER.match(contents)
    return {} unless match

    YAML.safe_load(match[1], permitted_classes: [ Date, Time ]) || {}
  end

  def parse_date(value)
    Date.parse(value.to_s) if value.present?
  end
end
