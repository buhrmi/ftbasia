require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "renders an article for the requested locale" do
    get article_path(locale: :ja, slug: "founder-interview")

    assert_response :success
    assert_inertia_component "articles/show"
    assert_equal "ja", inertia_props["locale"]
  end

  test "renders the article index" do
    get articles_path(locale: :ja)

    assert_response :success
    assert_inertia_component "articles/index"
    assert_equal 1, inertia_props["articles"].size
    assert_equal "http://www.example.com/ja/articles", inertia_props["canonical_url"]
    assert_equal "website", inertia_props["og_type"]
  end

  test "returns not found for unknown articles" do
    get article_path(slug: "does-not-exist")

    assert_response :not_found
  end

  test "redirects the root path to the Japanese article index" do
    get "/"

    assert_redirected_to "/ja/articles"
  end

  test "returns not found for locales the article does not exist in" do
    get article_path(locale: :en, slug: "founder-interview")

    assert_response :not_found
  end

  test "passes social preview metadata" do
    get article_path(locale: :ja, slug: "founder-interview")

    assert_equal "http://www.example.com", inertia_props["origin"]
    assert_equal "http://www.example.com/ja/articles/founder-interview", inertia_props["canonical_url"]
    assert_equal "article", inertia_props["og_type"]
    assert_equal "ja_JP", inertia_props["og_locale"]
    assert_equal "2026-10-30", inertia_props["published_at"]
    refute inertia_props.key?("image_url"), "pages render the Vite-imported og:image themselves"
  end

  private

  def inertia_props
    JSON.parse(Nokogiri::HTML(response.body).at_css("script[data-page]").text)["props"]
  end

  def assert_inertia_component(component)
    page = JSON.parse(Nokogiri::HTML(response.body).at_css("script[data-page]").text)
    assert_equal component, page["component"]
  end
end
