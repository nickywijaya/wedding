class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def confirm!
    self.confirmed_at = Time.now
    self.save!
  end

  def confirmed?
    self.confirmed_at.present?
  end
end
