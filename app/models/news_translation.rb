class NewsTranslation < ApplicationRecord
  belongs_to :news_article

  validates :locale, inclusion: { in: %w[en ja] }, uniqueness: { scope: :news_article_id }
  validates :title, presence: true
end
