class Event < ApplicationRecord
  include LocalizedContent

  belongs_to :venue, optional: true
  has_one_attached :flyer
  has_many :event_artists, -> { order(:position, :id) }, dependent: :destroy
  has_many :artists, through: :event_artists
  has_many :event_promoters, -> { order(:position, :id) }, dependent: :destroy
  has_many :promoters, through: :event_promoters
  has_many :news_events, dependent: :destroy
  has_many :news_articles, through: :news_events

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }
  validates :timezone, presence: true

  scope :chronological, -> { order(:starts_at, :id) }

  def upcoming?(now = Time.current)
    return false unless starts_at

    local_start = starts_at.in_time_zone(timezone)
    local_now = now.in_time_zone(timezone)
    all_day? ? local_start.to_date >= local_now.to_date : starts_at > now
  end
end
