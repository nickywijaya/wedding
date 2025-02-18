class Invitation < ApplicationRecord
  self.table_name = "invitations"

  has_many :invitation_guests, class_name: 'InvitationGuest', foreign_key: :invitation_id
  has_many :guests, class_name: 'Guest', through: :invitation_guests

  belongs_to :wedding, class_name: 'Weddings'

  ATTENDANCE_TYPE = {
    "0".to_sym => 'Holy Matrimony',
    "1".to_sym => 'Reception',
    "2".to_sym => 'Both' # invited to both event
  }

  ATTENDANCE_TYPE_ENUM = {
    :holy_matrimony => 0,
    :reception => 1,
    :both => 2 # invited to both event
  }

  def fetch_attendance_type
    ATTENDANCE_TYPE[self.attendance_type.to_s.to_sym]
  end

  def fetch_attending_info
    if self.attending.nil?
      "Not Confirmed"
    else
      self.attending ? "Attend" : "Not Attend"
    end
  end
end
