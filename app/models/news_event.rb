class NewsEvent < ApplicationRecord
  belongs_to :news_article
  belongs_to :event

  validates :event_id, uniqueness: { scope: :news_article_id }
end
