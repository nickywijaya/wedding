class Weddings < ApplicationRecord
  self.table_name = "weddings"

  has_many :wedding_venues, class_name: 'WeddingVenue', foreign_key: :wedding_id
  has_many :venues, class_name: 'Venue', through: :wedding_venues

  has_many :invitations, class_name: 'Invitation', foreign_key: :wedding_id
  has_many :invitation_guests, class_name: 'InvitationGuest', through: :invitations
  has_many :guests, class_name: 'Guest', through: :invitation_guests
end
