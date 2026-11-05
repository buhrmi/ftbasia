class NewsArticle < ApplicationRecord
  has_many :translations, class_name: "NewsTranslation", dependent: :destroy
  has_one_attached :cover_image
  has_many_attached :images
  has_many :news_artists, dependent: :destroy
  has_many :artists, through: :news_artists
  has_many :news_events, dependent: :destroy
  has_many :events, through: :news_events
  has_many :news_promoters, dependent: :destroy
  has_many :promoters, through: :news_promoters
  has_many :embeds, -> { order(:position, :id) }, class_name: "NewsEmbed", dependent: :destroy

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }
  validates :category, :published_at, presence: true

  scope :published, -> { where("published_at <= ?", Date.current).order(published_at: :desc, id: :desc) }

  def translation(locale)
    translations.find { |item| item.locale == locale.to_s } ||
      translations.find { |item| item.locale == "ja" } ||
      translations.first
  end
end
