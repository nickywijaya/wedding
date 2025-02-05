class Venue < ApplicationRecord
  self.table_name = "venues"

  has_one :wedding, class_name: 'Weddings'
end
