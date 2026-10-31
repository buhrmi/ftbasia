class EventsController < ApplicationController
  include NewsPresentation

  def show
    event = Event.find(params[:slug])
    raise ActiveRecord::RecordNotFound, "Event not found" unless event

    @meta = page_meta(title: event.name, description: event.bio(locale: I18n.locale))
    @locale = I18n.locale.to_s
    @profile = event.to_props(locale: I18n.locale)
    @news = event.tagged_news(locale: I18n.locale).map { |news| news_props(news) }
  end
end
