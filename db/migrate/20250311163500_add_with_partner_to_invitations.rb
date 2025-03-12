class AddWithPartnerToInvitations < ActiveRecord::Migration[6.0]
  def change
    change_table :invitations do |t|
      t.boolean :with_partner, default: nil
    end
  end
end
