class CreateGuestsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :guests, id: :integer, unsigned: true, limit: 8 do |t|
      t.string :name
      t.integer :gender, unsigned: true, limit: 1

      t.timestamps
    end
  end

  def down
    drop_table :guests
  end
end
