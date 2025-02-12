class Invitation < ApplicationRecord
  self.table_name = "invitations"

  has_many :invitation_guests, class_name: 'InvitationGuest', foreign_key: :invitation_id
  has_many :guests, class_name: 'Guest', through: :invitation_guests

  belongs_to :wedding, class_name: 'Weddings'

  def fetch_attending_info
    if self.attending.nil?
      "Not Confirmed"
    else
      self.attending ? "Attend" : "Not Attend"
    end
  end
end
