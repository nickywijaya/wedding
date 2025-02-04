class InvitationGuest < ApplicationRecord
  self.table_name = "invitation_guests"

  belongs_to :invitation, class_name: "Invitation", foreign_key: :invitation_id
  belongs_to :guest, class_name: "Guest", foreign_key: :guest_id
end
