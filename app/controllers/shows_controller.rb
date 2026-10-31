class ShowsController < ApplicationController
  def show
    show = Show.find(params[:slug])
    raise ActiveRecord::RecordNotFound, "Show not found" unless show

    @meta = page_meta(
      title: show.name(locale: I18n.locale),
      description: show.description(locale: I18n.locale),
      type: "article",
      published_at: show.starts_at.iso8601
    )
    @locale = I18n.locale.to_s
    @show = show.to_props(locale: I18n.locale)
    @event = show.event&.to_props(locale: I18n.locale)
  end
end
