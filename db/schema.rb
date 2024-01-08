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


ActiveRecord::Schema[7.1].define(version: 2023_12_26_165720) do
  create_table "card_type_attributes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_types", force: :cascade do |t|
    t.integer "card_type_attribute_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "card_text"
    t.integer "cost"
    t.text "flavor_text"
    t.string "rarity"
    t.string "card_art_url"
    t.string "type"
    t.integer "attack"
    t.integer "health"
    t.integer "armor"
    t.integer "durability"
    t.integer "expansion_id", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_token"
  end

  create_table "connected_cards", force: :cascade do |t|
    t.integer "master_card_id"
    t.integer "child_card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expansion_groups", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.string "icon_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expansions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "tagline"
    t.integer "expansion_group_id", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_class_cards", force: :cascade do |t|
    t.integer "player_class_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_classes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scale_powers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "art_url"
    t.integer "player_class_id"
    t.integer "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hero_card_id"
  end

end
