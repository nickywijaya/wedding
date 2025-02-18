class WeddingVenue < ApplicationRecord
  self.table_name = "wedding_venues"

  belongs_to :wedding, class_name: "Weddings", foreign_key: :wedding_id
  belongs_to :venue, class_name: "Venue", foreign_key: :venue_id
end
