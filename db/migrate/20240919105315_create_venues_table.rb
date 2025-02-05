class CreateVenuesTable < ActiveRecord::Migration[5.2]
  def up
    create_table :venues, id: :integer, unsigned: true, limit: 8 do |t|
      t.string :name
      t.string :address
      t.text :map_src
      t.datetime :start_time
      t.datetime :end_time
      t.integer :max_attendees

      t.timestamps
    end
  end

  def down
    drop_table :venues
  end
end
