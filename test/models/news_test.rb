require "test_helper"
require "tmpdir"

class NewsTest < ActiveSupport::TestCase
  test "index falls back to the first translation for untranslated items" do
    with_content_dir do |dir|
      write_news(dir, "japanese-only", "ja", title: "Japanese title")
      write_news(dir, "bilingual", "ja", title: "Japanese title")
      write_news(dir, "bilingual", "en", title: "English title")

      news = News.all_for_index(locale: :en)

      japanese_only = news.find { |item| item.slug == "japanese-only" }
      assert_equal "ja", japanese_only.locale
      assert_equal "Japanese title", japanese_only.title

      bilingual = news.find { |item| item.slug == "bilingual" }
      assert_equal "en", bilingual.locale
      assert_equal "English title", bilingual.title
    end
  end

  test "find returns nil when the requested locale is missing" do
    with_content_dir do |dir|
      write_news(dir, "japanese-only", "ja", title: "Japanese title")

      assert_nil News.find(locale: :en, slug: "japanese-only")
      assert_equal "ja", News.find(locale: :ja, slug: "japanese-only").locale
    end
  end

  private

  def with_content_dir
    Dir.mktmpdir do |dir|
      stub_const(News, :CONTENT_DIR, Pathname(dir)) do
        yield dir
      end
    end
  end

  def write_news(dir, slug, locale, title:)
    path = Pathname(dir).join(slug, "#{locale}.md")
    path.dirname.mkpath
    path.write(<<~MARKDOWN)
      ---
      title: #{title}
      description: Description
      published_at: 2026-10-30
      ---
      Body
    MARKDOWN
  end
end
