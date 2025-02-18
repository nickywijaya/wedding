class CreateWeddingVenuesTable < ActiveRecord::Migration[5.2]
  def up
    create_table :wedding_venues, id: :integer, unsigned: true, limit: 8 do |t|
      t.integer :wedding_id
      t.integer :venue_id

      t.timestamps
    end
  end

  def down
    drop_table :wedding_venues
  end
end
