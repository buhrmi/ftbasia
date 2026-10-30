class Article
  CONTENT_DIR = Rails.root.join("app/frontend/content/articles")
  SLUG_PATTERN = /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/
  FRONT_MATTER = /\A---\s*\n(.*?)\n---\s*\n/m

  attr_reader :slug, :locale, :title, :description, :published_at

  class << self
    def all(locale:)
      Dir.glob(CONTENT_DIR.join("*", "#{locale}.md"))
        .filter_map { |path| new(path) }
        .sort_by { |article| article.published_at || Date.new(1970, 1, 1) }
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
