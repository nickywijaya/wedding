class Guest < ApplicationRecord
  self.table_name = 'guests'

  GENDER = {
    "0".to_sym => 'female',
    "1".to_sym => 'male'
  }

  def fetch_gender
    GENDER[self.gender.to_s.to_sym]
  end

  has_many :invitation_guests
  has_many :invitations
end
