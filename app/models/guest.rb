class Guest < ApplicationRecord
  self.table_name = 'guests'

  GENDER = {
    "0".to_sym => 'female',
    "1".to_sym => 'male'
  }

  CONTACT_SOURCE = {
    "0".to_sym => 'whatsapp',
    "1".to_sym => 'instagram',
    "2".to_sym => 'tiktok'
  }

  def fetch_gender
    GENDER[self.gender.to_s.to_sym]
  end

  def fetch_contact_source
    CONTACT_SOURCE[self.contact_source.to_s.to_sym]
  end

  def fetch_guest_source
    self.from_groom ? "groom" : "bride"
  end

  def fetch_invitation
    self.invitations.first&.id
  end

  has_many :invitation_guests, class_name: 'InvitationGuest', foreign_key: :guest_id
  has_many :invitations, class_name: 'Invitation', through: :invitation_guests
end
