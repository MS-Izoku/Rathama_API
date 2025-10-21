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

ActiveRecord::Schema[7.1].define(version: 2025_09_22_012613) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "api_keys", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "api_key_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active"
    t.index ["api_key_digest"], name: "index_api_keys_on_api_key_digest", unique: true
    t.index ["owner_id", "owner_type"], name: "index_api_keys_on_owner_id_and_owner_type"
  end

  create_table "card_mechanic_assignments", force: :cascade do |t|
    t.integer "card_id"
    t.string "as_string"
    t.string "lifecycle_stage"
    t.string "mechanic_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_mechanics", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "args"
    t.string "as_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_trait", default: false
  end

  create_table "card_ownerships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_packs", force: :cascade do |t|
    t.integer "expansion_id"
    t.integer "cards_per_pack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.string "type"
    t.integer "attack"
    t.integer "health"
    t.integer "armor"
    t.integer "durability"
    t.integer "expansion_id", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_generated_card"
    t.string "deck_size_modifier_type", default: "None"
    t.integer "deck_size_modifier_value"
    t.text "unity_text"
    t.text "unity_flavor_text"
    t.string "upload_token"
    t.boolean "excluded_from_deckbuilding", default: false
  end

  create_table "connected_cards", force: :cascade do |t|
    t.integer "master_card_id"
    t.integer "child_card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deck_cards", force: :cascade do |t|
    t.integer "deck_id"
    t.integer "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deck_classes", force: :cascade do |t|
    t.integer "deck_id"
    t.integer "player_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deck_code"
    t.string "generation_status"
    t.boolean "is_playable", default: false
    t.string "playability_status"
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
    t.date "release_date"
    t.boolean "on_time", default: false
    t.date "expected_release_date"
    t.boolean "released"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_card_packs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "user_id"
    t.integer "card_pack_id"
    t.datetime "date_opened"
    t.boolean "opened"
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

  create_table "player_quests", force: :cascade do |t|
    t.integer "user_id"
    t.integer "quest_id"
    t.integer "current_completion_value", default: 0
    t.integer "target_completion_value", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expiration_date"
    t.boolean "is_completed"
  end

  create_table "quest_rewards", force: :cascade do |t|
    t.integer "quest_id"
    t.integer "rewardable_id"
    t.string "rewardable_type"
    t.integer "quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "target_completion_value"
    t.string "quest_type", default: "Daily"
    t.datetime "expiration"
    t.boolean "can_expire", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rewards", force: :cascade do |t|
    t.integer "quantity"
    t.string "rewardable_type", null: false
    t.bigint "rewardable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rewardable_type", "rewardable_id"], name: "index_rewards_on_rewardable"
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

  create_table "seed_update_infos", force: :cascade do |t|
    t.datetime "card_type_attributes"
    t.datetime "basic_cards"
    t.string "mechanics_datetime"
    t.datetime "decks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_currencies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "currency_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key_digest"
    t.datetime "last_daily_quest_given_date"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
