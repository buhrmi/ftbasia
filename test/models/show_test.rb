require "test_helper"

class ShowTest < ActiveSupport::TestCase
  test "finds a show and its event" do
    show = Show.find("far-too-loud")

    assert_equal "far-too-loud", show.slug
    assert_equal "tokyo-bass-conference", show.event_slug
    assert_equal "Tokyo Bass Conference", show.event.name
    assert_equal 2016, show.starts_at.year
  end

  test "lists shows for an event" do
    assert_equal [ "far-too-loud" ],
      Show.for_event("tokyo-bass-conference").map(&:slug)
    assert_empty Show.for_event("beginning-tokyo")
  end

  test "serializes localized show props" do
    props = Show.find("far-too-loud").to_props(locale: :ja)

    assert_equal "Tokyo Bass Conference feat. Far Too Loud", props[:name]
    assert_equal "共同企画", props[:kind]
    assert_equal "2016-01-23T22:00:00+09:00", props[:starts_at]
    assert_equal 2016, props[:year]
    assert_equal "東京", props[:location]
    assert_equal [ "Far Too Loud" ], props[:performers]
    assert_equal "ブッキング", props[:work].first[:title]
    assert_equal "2016-far-too-loud.jpg", props[:flyer]

    english = Show.find("far-too-loud").to_props(locale: :en)
    assert_equal "Joint project", english[:kind]
    assert_equal "Tokyo, Japan", english[:location]
    assert_equal "Booking", english[:work].first[:title]
  end

  test "returns nil for unknown shows" do
    assert_nil Show.find("missing-show")
  end
end
