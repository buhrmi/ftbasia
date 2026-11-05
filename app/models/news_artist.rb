class NewsArtist < ApplicationRecord
  belongs_to :news_article
  belongs_to :artist

  validates :artist_id, uniqueness: { scope: :news_article_id }
end
