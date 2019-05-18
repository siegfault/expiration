# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_18_195537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foods", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.date "expiration", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.date "eaten_on"
    t.date "trashed_on"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "provider"
    t.text "uid"
    t.text "first_name"
    t.text "last_name"
    t.text "token"
    t.text "refresh_token"
    t.datetime "oauth_expires_at"
  end

end
