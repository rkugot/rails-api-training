# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190501075136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_results", force: :cascade do |t|
    t.decimal "usd", precision: 7, scale: 4
    t.decimal "eur", precision: 7, scale: 4
    t.decimal "rur", precision: 7, scale: 4
    t.datetime "created_at"
  end

  create_table "source_providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "address", null: false
    t.datetime "last_sync_at"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
