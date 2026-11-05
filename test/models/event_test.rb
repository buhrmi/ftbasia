require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "all-day events remain upcoming for their full local calendar day" do
    zone = Time.find_zone!("Asia/Tokyo")
    event = Event.new(timezone: zone.name, starts_at: zone.parse("2025-01-02"), all_day: true)

    assert event.upcoming?(zone.parse("2025-01-02 23:59"))
    refute event.upcoming?(zone.parse("2025-01-03"))
  end

  test "timed events stop being upcoming at their start time" do
    zone = Time.find_zone!("Asia/Ho_Chi_Minh")
    event = Event.new(timezone: zone.name, starts_at: zone.parse("2025-01-02 22:00"), all_day: false)

    assert event.upcoming?(zone.parse("2025-01-02 21:59"))
    refute event.upcoming?(zone.parse("2025-01-02 22:00"))
  end
end
