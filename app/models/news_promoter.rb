class NewsPromoter < ApplicationRecord
  belongs_to :news_article
  belongs_to :promoter

  validates :promoter_id, uniqueness: { scope: :news_article_id }
end
