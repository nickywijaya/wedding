class AddConfirmableToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.datetime :confirmed_at, default: nil
    end
  end
end
