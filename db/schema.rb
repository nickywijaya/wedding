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

ActiveRecord::Schema.define(version: 2025_02_18_093000) do

  create_table "guests", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.integer "gender", limit: 1, unsigned: true
    t.string "contact"
    t.integer "contact_source", limit: 1, unsigned: true
    t.boolean "from_groom"
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
    t.integer "wedding_id"
    t.integer "attendance_type", limit: 1, unsigned: true
    t.boolean "attending"
    t.integer "participant"
    t.string "comments"
    t.boolean "with_family"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "confirmed_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "map_src"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "max_attendees"
    t.integer "venue_type", limit: 1, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wedding_venues", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", force: :cascade do |t|
    t.integer "wedding_id"
    t.integer "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weddings", id: { type: :bigint, unsigned: true }, charset: "utf8mb3", force: :cascade do |t|
    t.string "groom"
    t.string "bride"
    t.string "story"
    t.string "hashtag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
