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

ActiveRecord::Schema.define(version: 2020_03_23_234127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cloak_policy_categories", force: :cascade do |t|
    t.string "description"
    t.string "icon"
    t.string "name"
    t.string "parent_type"
    t.integer "parent_id"
    t.integer "row_order"
    t.string "category_type"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cloak_policy_platforms", force: :cascade do |t|
    t.string "name"
    t.string "fqdn"
    t.string "description"
    t.string "icon"
    t.string "platform_type"
    t.string "they_say"
    t.string "we_say"
    t.boolean "recommendable"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
