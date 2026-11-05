class ArtistsController < InertiaController
  def index
    artists = Artist.where(featured: true).order(:slug).with_attached_avatar

    render inertia: {
      artists: artists.map { |artist| artist_props(artist) },
      meta: page_meta(
        I18n.locale == :ja ? "アーティスト" : "Artists",
        I18n.locale == :ja ?
          "注目アーティストのプロフィールや活動情報を紹介します。" :
          "Discover artists featured on Follow The Bass and learn more about their work.",
        "/artists"
      )
    }
  end

  def show
    artist = Artist.find_by!(slug: params[:slug])
    articles = artist.news_articles.published
      .includes(:translations, :artists, :events, cover_image_attachment: :blob)

    render inertia: {
      artist: artist_props(artist),
      news: articles.filter_map { |article| news_props(article) },
      meta: page_meta(artist.display_name_for, artist.localized(:bio, I18n.locale), "/artists/#{artist.slug}")
    }
  end
end
