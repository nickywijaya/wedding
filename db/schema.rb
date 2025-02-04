# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_09_19_105315) do

  create_table "guests", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "gender", limit: 1, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitation_guests", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", force: :cascade do |t|
    t.string "invitation_id"
    t.integer "guest_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", id: :string, charset: "utf8mb3", force: :cascade do |t|
    t.integer "venue_id"
    t.boolean "attending"
    t.string "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "map_src"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
