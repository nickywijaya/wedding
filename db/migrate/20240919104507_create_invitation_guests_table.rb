class CreateInvitationGuestsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :invitation_guests, id: :integer, unsigned: true, limit: 8 do |t|
      t.string :invitation_id
      t.integer :guest_id

      t.timestamps
    end
  end

  def down
    drop_table :invitation_guests
  end
end
