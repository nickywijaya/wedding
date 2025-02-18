class Venue < ApplicationRecord
  self.table_name = "venues"

  has_many :wedding_venues, class_name: 'WeddingVenue', foreign_key: :venue_id
  has_many :weddings, class_name: 'Weddings', through: :wedding_venues

  has_many :invitations, class_name: 'Invitation', through: :weddings
  has_many :invitation_guests, class_name: 'InvitationGuest', through: :invitations
  has_many :guests, class_name: 'Guest', through: :invitation_guests

  scope :holy_matrimony, -> { find_by(venue_type: VENUE_TYPE_ENUM[:holy_matrimony]) }
  scope :reception, -> { find_by(venue_type: VENUE_TYPE_ENUM[:reception]) }

  VENUE_TYPE = {
    "0".to_sym => 'Holy Matrimony',
    "1".to_sym => 'Reception'
  }

  VENUE_TYPE_ENUM = {
    :holy_matrimony => 0,
    :reception => 1
  }

  def fetch_venue_type
    VENUE_TYPE[self.venue_type.to_s.to_sym]
  end

  def fetch_attended_attendees
    if self.venue_type == VENUE_TYPE_ENUM[:reception]
      self.invitations.where(attendance_type: [Invitation::ATTENDANCE_TYPE_ENUM[:reception], Invitation::ATTENDANCE_TYPE_ENUM[:both]]).sum(&:participant)
    else
      self.invitations.where(attendance_type: [Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony], Invitation::ATTENDANCE_TYPE_ENUM[:both]]).sum(&:participant)
    end
  end

  def fetch_absent_attendees
    if self.venue_type == VENUE_TYPE_ENUM[:reception]
      self.invitations.where(attendance_type: [Invitation::ATTENDANCE_TYPE_ENUM[:reception], Invitation::ATTENDANCE_TYPE_ENUM[:both]]).where(attending: false).sum(&:participant)
    else
      self.invitations.where(attendance_type: [Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony], Invitation::ATTENDANCE_TYPE_ENUM[:both]]).where(attending: false).sum(&:participant)
    end
  end

  def fetch_not_confirmed_attendees
    if self.venue_type == VENUE_TYPE_ENUM[:reception]
      self.invitations.where(attendance_type: [Invitation::ATTENDANCE_TYPE_ENUM[:reception], Invitation::ATTENDANCE_TYPE_ENUM[:both]]).where(attending: nil).sum(&:participant)
    else
      self.invitations.where(attendance_type: [Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony], Invitation::ATTENDANCE_TYPE_ENUM[:both]]).where(attending: nil).sum(&:participant)
    end
  end
end
