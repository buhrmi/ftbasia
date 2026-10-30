class ArticlesController < ApplicationController
  def index
    render inertia: "articles/index", props: page_meta(
      title: t("articles.index_title"),
      description: t("articles.index_description")
    ).merge(
      locale: I18n.locale.to_s,
      articles: Article.all(locale: I18n.locale).map { |article| article_props(article) }
    )
  end

  def show
    article = Article.find(locale: I18n.locale, slug: params[:slug])
    raise ActiveRecord::RecordNotFound, "Article not found" if article.nil?

    render inertia: "articles/show", props: page_meta(
      title: article.title,
      description: article.description,
      type: "article",
      published_at: article.published_at&.iso8601
    ).merge(
      locale: article.locale,
      slug: article.slug,
      article: article_props(article),
      articles_url: articles_path(locale: prefixed_locale(I18n.locale))
    )
  end

  private

  def article_props(article)
    {
      slug: article.slug,
      locale: article.locale,
      title: article.title,
      description: article.description,
      published_at: article.published_at&.iso8601,
      url: article_path(slug: article.slug, locale: prefixed_locale(article.locale))
    }
  end

  def prefixed_locale(locale)
    locale.to_s == I18n.default_locale.to_s ? nil : locale
  end
end
