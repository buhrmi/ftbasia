class ArtistsController < ApplicationController
  include NewsPresentation

  def show
    artist = Artist.find(params[:slug])
    raise ActiveRecord::RecordNotFound, "Artist not found" unless artist

    @meta = page_meta(title: artist.name, description: artist.bio(locale: I18n.locale))
    @locale = I18n.locale.to_s
    @profile = artist.to_props(locale: I18n.locale)
    @news = artist.tagged_news(locale: I18n.locale).map { |news| news_props(news) }
  end
end
