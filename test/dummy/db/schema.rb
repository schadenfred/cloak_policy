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

ActiveRecord::Schema.define(version: 2020_06_25_232948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cloak_policy_choices", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.integer "setting_id"
    t.integer "weight"
    t.string "we_say"
    t.string "they_say"
    t.boolean "recommendable"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cloak_policy_chosens", force: :cascade do |t|
    t.integer "choice_id"
    t.integer "recommendation_id"
    t.string "advice"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["choice_id"], name: "index_cloak_policy_chosens_on_choice_id"
    t.index ["recommendation_id"], name: "index_cloak_policy_chosens_on_recommendation_id"
  end

  create_table "cloak_policy_intentions", force: :cascade do |t|
    t.string "intendable_type", null: false
    t.integer "intendable_id", null: false
    t.integer "intent_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["intendable_type", "intendable_id"], name: "index_cloak_policy_intendable"
    t.index ["intent_id"], name: "index_cloak_policy_intentions_on_intent_id"
  end

  create_table "cloak_policy_intents", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "weight"
    t.integer "vector_id", null: false
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

  create_table "cloak_policy_recommendations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "recommender_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recommender_id"], name: "index_cloak_policy_recommendations_on_recommender_id"
  end

  create_table "cloak_policy_scores", force: :cascade do |t|
    t.string "scorable_type"
    t.integer "scorable_id"
    t.integer "vector_id"
    t.string "impact"
    t.integer "weight", default: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["scorable_type", "scorable_id"], name: "index_cloak_policy_scores_on_scorable_type_and_scorable_id"
  end

  create_table "cloak_policy_settings", force: :cascade do |t|
    t.string "name"
    t.string "edit_url"
    t.integer "platform_id"
    t.integer "row_order"
    t.boolean "recommendable"
    t.string "they_say"
    t.string "we_say"
    t.string "page"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["platform_id"], name: "index_cloak_policy_settings_on_platform_id"
  end

  create_table "cloak_policy_vectors", force: :cascade do |t|
    t.string "description"
    t.string "icon"
    t.string "name"
    t.integer "parent_id"
  end

end
