require "uri"

class NewsEmbed < ApplicationRecord
  ALLOWED_HOSTS = %w[w.soundcloud.com www.youtube.com www.instagram.com].freeze

  belongs_to :news_article

  validates :title, :source_url, :provider, presence: true
  validates :height, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1200 }
  validate :source_url_uses_approved_host

  private

  def source_url_uses_approved_host
    uri = URI.parse(source_url)
    return if uri.scheme == "https" && ALLOWED_HOSTS.include?(uri.host)

    errors.add(:source_url, "must use an approved HTTPS embed host")
  rescue URI::InvalidURIError
    errors.add(:source_url, "is invalid")
  end
end
