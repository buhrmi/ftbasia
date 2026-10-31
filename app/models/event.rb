class Event < Profile
  CONTENT_DIR = Rails.root.join("app/frontend/content/events")
  TAG_TYPE = "event"

  def shows
    Show.for_event(slug)
  end
end
