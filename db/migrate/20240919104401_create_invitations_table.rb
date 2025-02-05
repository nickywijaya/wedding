class CreateInvitationsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :invitations, id: :string do |t|
      t.integer :wedding_id
      t.boolean :attending, null: true
      t.integer :participant
      t.string :comments

      t.timestamps
    end
  end

  def down
    drop_table :invitations
  end
end
