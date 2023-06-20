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

ActiveRecord::Schema[7.0].define(version: 2023_06_20_163847) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "token_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["token_digest"], name: "index_api_keys_on_token_digest", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.string "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile"], name: "index_authors_on_profile", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.string "level"
    t.string "total_time"
    t.string "servings"
    t.string "directions", default: [], array: true
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "author_id"
    t.string "ingredients", default: [], array: true
    t.string "time_descriptions", default: [], array: true
    t.string "source", null: false
  end

  create_table "tags", id: false, force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id", "recipe_id"], name: "index_tags_on_category_id_and_recipe_id"
    t.index ["recipe_id", "category_id"], name: "index_tags_on_recipe_id_and_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "api_keys", "users"
  add_foreign_key "recipes", "authors"
end
