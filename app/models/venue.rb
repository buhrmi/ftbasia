class Venue < ApplicationRecord
  include LocalizedContent

  has_many :events, dependent: :nullify
  has_many_attached :images

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }
end
