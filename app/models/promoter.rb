class Promoter < ApplicationRecord
  include LocalizedContent

  has_one_attached :logo
  has_many :event_promoters, dependent: :destroy
  has_many :events, through: :event_promoters
  has_many :news_promoters, dependent: :destroy
  has_many :news_articles, through: :news_promoters

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }
end
