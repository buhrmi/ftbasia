require "test_helper"

class ContentPagesTest < ActionDispatch::IntegrationTest
  test "English home page returns locale-aware Inertia props" do
    get "/en"

    assert_response :success
    page = inertia_page
    assert_equal "home/index", page.fetch("component")
    assert_equal "en", page.dig("props", "locale")
  end

  test "news detail serves the selected translation" do
    article = NewsArticle.create!(slug: "request-test", category: "announcement", published_at: Date.current)
    article.translations.create!(locale: "en", title: "Test article", description: "", body_markdown: "Hello")
    article.translations.create!(locale: "ja", title: "テスト記事", description: "", body_markdown: "こんにちは")

    get "/en/news/request-test"

    assert_response :success
    page = inertia_page
    assert_equal "news/show", page.fetch("component")
    assert_equal "Test article", page.dig("props", "news", "title")
    assert_equal "en", page.dig("props", "locale")
  end

  test "artist display name is localized without changing its handle" do
    artist = Artist.create!(
      slug: "stefan",
      name: "Da Nang Bassman (Stefan)",
      display_name: { en: "ステファン (Stefan)", ja: "ステファン" }
    )

    get "/en/artists/#{artist.slug}"

    assert_response :success
    assert_equal "ステファン (Stefan)", inertia_page.dig("props", "artist", "name")
    assert_equal "ステファン (Stefan) — Follow The Bass", inertia_page.dig("props", "meta", "title")
    assert_equal "stefan", inertia_page.dig("props", "artist", "slug")

    get "/artists/#{artist.slug}"

    assert_response :success
    assert_equal "ステファン", inertia_page.dig("props", "artist", "name")
    assert_equal "ステファン — Follow The Bass", inertia_page.dig("props", "meta", "title")
    assert_equal "stefan", inertia_page.dig("props", "artist", "slug")

    get "/artists/danangbassman"

    assert_response :moved_permanently
    assert_redirected_to "/artists/stefan"

    get "/en/artists/danangbassman"

    assert_response :moved_permanently
    assert_redirected_to "/en/artists/stefan"
  end

  private

  def inertia_page
    script = Nokogiri::HTML(response.body).at_css('script[data-page="app"]')
    JSON.parse(script.text)
  end
end
