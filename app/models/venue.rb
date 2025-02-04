class Venue < ApplicationRecord
  self.table_name = "venues"

  has_one :invitations, class_name: 'Invitation', foreign_key: :venue_id
end
