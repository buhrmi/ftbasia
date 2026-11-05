class EventArtist < ApplicationRecord
  belongs_to :event
  belongs_to :artist

  validates :artist_id, uniqueness: { scope: :event_id }
end
