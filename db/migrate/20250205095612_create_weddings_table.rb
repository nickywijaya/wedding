class CreateWeddingsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :weddings, id: :integer, unsigned: true, limit: 8 do |t|
      t.string :couple_1
      t.string :couple_2
      t.string :story
      t.string :hashtag
      t.integer :venue_id
      t.integer :attendees

      t.timestamps
    end
  end

  def down
    drop_table :venues
  end
end
