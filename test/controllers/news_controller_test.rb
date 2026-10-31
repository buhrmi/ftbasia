require "test_helper"

class NewsControllerTest < ActionDispatch::IntegrationTest
  test "renders a news item in the default Japanese locale" do
    get news_path(slug: "stefan-opens-up-after-8-years-in-tokyo")

    assert_response :success
    assert_inertia_component "news/show"
    assert_equal "ja", inertia_props["locale"]
    assert_equal [
      { "type" => "artist", "slug" => "stefan", "name" => "Stefan", "url" => "/artists/stefan" },
      {
        "type" => "event",
        "slug" => "beginning-tokyo",
        "name" => "Beginning Tokyo",
        "url" => "/events/beginning-tokyo"
      }
    ], inertia_props["news"]["tags"]
  end

  test "renders the news index" do
    get news_index_path

    assert_response :success
    assert_inertia_component "news/index"
    sirius_slug = "allen-mock-and-tha-boogie-bandit-debut-on-ophelia-records-with-sirius"
    assert_includes inertia_props["news"].map { |item| item["slug"] }, sirius_slug
    sirius = inertia_props["news"].find { |item| item["slug"] == sirius_slug }
    assert_equal "/news/#{sirius_slug}", sirius["url"]
    assert_equal "http://www.example.com/news", inertia_props["meta"]["canonical_url"]
    assert_equal "website", inertia_props["meta"]["og_type"]
  end

  test "news index prefers the selected locale when available" do
    get news_index_path(locale: :en)

    assert_response :success
    news = inertia_props["news"]
    slugs = news.map { |item| item["slug"] }

    stefan_slug = "stefan-opens-up-after-8-years-in-tokyo"
    sirius_slug = "allen-mock-and-tha-boogie-bandit-debut-on-ophelia-records-with-sirius"
    assert_equal 1, slugs.count(stefan_slug)
    assert_equal 1, slugs.count(sirius_slug)
    assert_equal "/en/news/#{stefan_slug}", news.find { |item| item["slug"] == stefan_slug }["url"]
    assert_equal "/en/news/#{sirius_slug}", news.find { |item| item["slug"] == sirius_slug }["url"]
    assert_equal "en", news.find { |item| item["slug"] == stefan_slug }["locale"]
  end

  test "renders the Sirius release with artist tags and publication date" do
    %i[en ja].each do |locale|
      get news_path(locale:, slug: "allen-mock-and-tha-boogie-bandit-debut-on-ophelia-records-with-sirius")

      assert_response :success
      assert_inertia_component "news/show"
      assert_equal locale.to_s, inertia_props["locale"]
      assert_equal "2022-08-19", inertia_props["news"]["published_at"]
      assert_equal [
        { "type" => "artist", "slug" => "allen-mock", "name" => "Allen Mock",
          "url" => locale == :ja ? "/artists/allen-mock" : "/en/artists/allen-mock" },
        {
          "type" => "artist",
          "slug" => "tha-boogie-bandit",
          "name" => "Tha Boogie Bandit",
          "url" => locale == :ja ? "/artists/tha-boogie-bandit" : "/en/artists/tha-boogie-bandit"
        }
      ], inertia_props["news"]["tags"]
    end
  end

  test "renders the Domination bootleg news item with artist tags" do
    %i[en ja].each do |locale|
      get news_path(locale:, slug: "dj-aki-and-yellock-bootleg-domination")

      assert_response :success
      assert_inertia_component "news/show"
      assert_equal locale.to_s, inertia_props["locale"]
      assert_equal "2026-10-31", inertia_props["news"]["published_at"]
      assert_equal [
        { "type" => "artist", "slug" => "dj-aki", "name" => "DJ AKi",
          "url" => locale == :ja ? "/artists/dj-aki" : "/en/artists/dj-aki" },
        { "type" => "artist", "slug" => "yellock", "name" => "YELLOCK",
          "url" => locale == :ja ? "/artists/yellock" : "/en/artists/yellock" }
      ], inertia_props["news"]["tags"]
    end
  end

  test "returns not found for unknown news items" do
    get news_path(slug: "does-not-exist")

    assert_response :not_found
  end

  test "redirects the root path to the Japanese news index" do
    get "/"

    assert_redirected_to "/news"
  end

  test "renders the English translation of a news item" do
    get news_path(locale: :en, slug: "stefan-opens-up-after-8-years-in-tokyo")

    assert_response :success
    assert_inertia_component "news/show"
    assert_equal "en", inertia_props["locale"]
    assert_equal "en", inertia_props["news"]["locale"]
    assert_match(/opens up about his experience/, inertia_props["news"]["title"])
  end

  test "passes social preview metadata" do
    get news_path(slug: "stefan-opens-up-after-8-years-in-tokyo")

    assert_equal "http://www.example.com", inertia_props["meta"]["origin"]
    assert_equal "http://www.example.com/news/stefan-opens-up-after-8-years-in-tokyo",
      inertia_props["meta"]["canonical_url"]
    assert_equal "article", inertia_props["meta"]["og_type"]
    assert_equal "ja_JP", inertia_props["meta"]["og_locale"]
    assert_equal "2026-10-30", inertia_props["meta"]["published_at"]
    refute inertia_props["meta"].key?("image_url"), "pages render the Vite-imported og:image themselves"
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
