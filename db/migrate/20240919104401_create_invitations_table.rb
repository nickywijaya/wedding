class CreateInvitationsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :invitations, id: :string do |t|
      t.integer :wedding_id
      t.integer :attendance_type, unsigned: true, limit: 1
      t.boolean :attending, null: true
      t.integer :participant
      t.string :comments
      t.boolean :with_family

      t.timestamps
    end
  end

  def down
    drop_table :invitations
  end
end
