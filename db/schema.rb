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

ActiveRecord::Schema[7.1].define(version: 2023_12_13_211307) do
  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "card_text"
    t.integer "cost"
    t.text "flavor_text"
    t.string "rarity"
    t.string "card_art_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expansions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "tagline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fiend_cards", force: :cascade do |t|
    t.integer "attack"
    t.integer "health"
    t.string "cardable_type"
    t.integer "cardable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cardable_type", "cardable_id"], name: "index_fiend_cards_on_cardable"
  end

  create_table "hero_cards", force: :cascade do |t|
    t.integer "armor"
    t.string "card_type", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_type", "card_id"], name: "index_hero_cards_on_card"
  end

  create_table "monument_cards", force: :cascade do |t|
    t.integer "durability"
    t.string "card_type", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_type", "card_id"], name: "index_monument_cards_on_card"
  end

  create_table "player_classes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spell_cards", force: :cascade do |t|
    t.string "card_type", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_type", "card_id"], name: "index_spell_cards_on_card"
  end

  create_table "trap_cards", force: :cascade do |t|
    t.string "card_type", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_type", "card_id"], name: "index_trap_cards_on_card"
  end

  create_table "weapon_cards", force: :cascade do |t|
    t.integer "durability"
    t.string "card_type", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_type", "card_id"], name: "index_weapon_cards_on_card"
  end

end
