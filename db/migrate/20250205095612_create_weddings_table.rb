class CreateWeddingsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :weddings, id: :integer, unsigned: true, limit: 8 do |t|
      t.string :groom
      t.string :bride
      t.string :story
      t.string :hashtag
      t.integer :venue_id

      t.timestamps
    end
  end

  def down
    drop_table :venues
  end
end
