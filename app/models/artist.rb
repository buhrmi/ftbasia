class Artist < ApplicationRecord
  include LocalizedContent

  has_one_attached :avatar
  has_many_attached :media
  has_many :event_artists, dependent: :destroy
  has_many :events, through: :event_artists
  has_many :news_artists, dependent: :destroy
  has_many :news_articles, through: :news_artists

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }
  validates :name, presence: true

  def display_name_for(locale = I18n.locale)
    localized(:display_name, locale).presence || name
  end
end
