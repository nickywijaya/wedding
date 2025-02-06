class Weddings < ApplicationRecord
  self.table_name = "weddings"

  belongs_to :venue, class_name: 'Venue', foreign_key: :venue_id

  has_many :invitations, class_name: 'Invitation', foreign_key: :wedding_id
  has_many :invitation_guests, class_name: 'InvitationGuest', through: :invitations
  has_many :guests, class_name: 'Guest', through: :invitation_guests

  def current_attendees
    self.invitations&.sum(:participant)
  end
end
