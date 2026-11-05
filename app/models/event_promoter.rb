class EventPromoter < ApplicationRecord
  belongs_to :event
  belongs_to :promoter

  validates :promoter_id, uniqueness: { scope: :event_id }
end
