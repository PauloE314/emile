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

ActiveRecord::Schema[7.0].define(version: 2022_06_13_110544) do
  create_table "ingredients", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.string "name", null: false
    t.integer "amount", null: false
    t.string "unit", null: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "creator_id", null: false
    t.string "name", null: false
    t.string "image_url"
    t.string "category"
    t.integer "servings"
    t.integer "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_recipes_on_creator_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.string "description", null: false
    t.integer "position", null: false
    t.index ["recipe_id"], name: "index_steps_on_recipe_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ingredients", "recipes"
  add_foreign_key "recipes", "users", column: "creator_id"
  add_foreign_key "steps", "recipes"
end
