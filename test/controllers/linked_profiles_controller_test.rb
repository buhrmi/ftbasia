require "test_helper"

class LinkedProfilesControllerTest < ActionDispatch::IntegrationTest
  test "artist page links to tagged news" do
    get artist_path(locale: :en, slug: "stefan")

    assert_response :success
    assert_inertia_component "artists/show"
    assert_equal "Stefan", inertia_props["profile"]["name"]
    assert_equal [ "/news/stefan-explains-why-he-is-starting-follow-the-bass" ],
      inertia_props["news"].map { |item| item["url"] }
  end

  test "artist page prefers the current locale when tagged news has a translation" do
    slug = "allen-mock-and-tha-boogie-bandit-debut-on-ophelia-records-with-sirius"

    get artist_path(locale: :en, slug: "allen-mock")
    assert_response :success
    assert_equal [ "/news/#{slug}" ], inertia_props["news"].map { |item| item["url"] }

    get artist_path(locale: :ja, slug: "allen-mock")
    assert_response :success
    assert_equal [ "/ja/news/#{slug}" ], inertia_props["news"].map { |item| item["url"] }
  end

  test "researched artist pages expose localized bios, links, and sources" do
    get artist_path(locale: :ja, slug: "allen-mock")

    assert_response :success
    profile = inertia_props["profile"]
    assert_equal "Allen Mock", profile["name"]
    assert_equal "Tokyo, Japan", profile["location"]
    assert_includes profile["bio"], "東京を拠点"
    assert_includes profile["links"].map { |link| link["url"] }, "https://allenmock.bandcamp.com/"
    assert_includes profile["sources"].map { |source| source["url"] },
      "https://gravitasrecordings.com/artist/allen-mock/"

    get artist_path(locale: :en, slug: "tha-boogie-bandit")

    assert_response :success
    profile = inertia_props["profile"]
    assert_equal "Tha Boogie Bandit", profile["name"]
    assert_equal "Tokyo, Japan", profile["location"]
    assert_includes profile["bio"], "Born in Los Angeles"
    assert_includes profile["sources"].map { |source| source["url"] },
      "https://thaboogiebandit.com/bio"
  end

  test "Stefan's page exposes localized interview details and media gallery" do
    get artist_path(locale: :en, slug: "stefan")

    assert_response :success
    profile = inertia_props["profile"]
    assert_equal "Artist & founder", profile["role"]
    assert_equal "Tokyo · Da Nang", profile["location"]
    assert_includes profile["bio"], "New Sound For Japan"
    assert_equal 6, profile["interview"].length
    assert_equal [ "tiktok", "video", "image" ], profile["media"].map { |item| item["kind"] }
    assert_equal "7610814398847847687", profile["media"].first["video_id"]
    assert_equal "stefan_illeffects.mp4", profile["media"][1]["asset"]
    assert_equal "founder.jpg", profile["media"][2]["asset"]

    get artist_path(locale: :ja, slug: "stefan")

    assert_response :success
    profile = inertia_props["profile"]
    assert_equal "アーティスト・創設者", profile["role"]
    assert_equal "東京・ダナン", profile["location"]
    assert_equal 6, profile["interview"].length
    assert_includes profile["interview"].first["question"], "New Sound For Japan"
  end

  test "event page links to tagged news" do
    get event_path(locale: :en, slug: "beginning-tokyo")

    assert_response :success
    assert_inertia_component "events/show"
    assert_equal "Beginning Tokyo", inertia_props["profile"]["name"]
    assert_equal [ "/news/stefan-explains-why-he-is-starting-follow-the-bass" ],
      inertia_props["news"].map { |item| item["url"] }
  end

  test "unknown artist and event pages return not found" do
    get artist_path(locale: :ja, slug: "missing-artist")
    assert_response :not_found

    get event_path(locale: :ja, slug: "missing-event")
    assert_response :not_found
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
