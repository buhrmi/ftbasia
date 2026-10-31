class NewsController < ApplicationController
  include NewsPresentation

  def index
    @meta = page_meta(
      title: t("news.index_title"),
      description: t("news.index_description")
    )
    @locale = I18n.locale.to_s
    @news = News.all_for_index(locale: I18n.locale).map { |news| news_props(news) }
  end

  def show
    news = News.find(locale: I18n.locale, slug: params[:slug])
    raise ActiveRecord::RecordNotFound, "News not found" if news.nil?

    @meta = page_meta(
      title: news.title,
      description: news.description,
      type: "article",
      published_at: news.published_at&.iso8601
    )
    @locale = news.locale
    @slug = news.slug
    @news = news_props(news)
    @news_url = news_index_path(locale: prefixed_locale(I18n.locale))
  end
end
