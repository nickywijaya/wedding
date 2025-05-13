class AddSentToInvitations < ActiveRecord::Migration[6.0]
  def change
    change_table :invitations do |t|
      t.boolean :sent, default: false
    end
  end
end
