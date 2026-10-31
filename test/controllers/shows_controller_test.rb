require "test_helper"

class ShowsControllerTest < ActionDispatch::IntegrationTest
  test "renders a show with its event" do
    get show_path(locale: :ja, slug: "far-too-loud")

    assert_response :success
    assert_inertia_component "shows/show"
    assert_equal "ja", inertia_props["locale"]
    assert_equal "far-too-loud", inertia_props["show"]["slug"]
    assert_equal "tokyo-bass-conference", inertia_props["event"]["slug"]
  end

  test "returns not found for unknown shows" do
    get show_path(locale: :ja, slug: "missing-show")

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
