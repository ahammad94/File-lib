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

ActiveRecord::Schema.define(version: 20170510205305) do

  create_table "aggregates", force: :cascade do |t|
    t.string   "file_name"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "file_type"
    t.string   "guid"
  end

  create_table "aggregates_categories", id: false, force: :cascade do |t|
    t.integer "aggregate_id", null: false
    t.integer "category_id",  null: false
    t.index ["aggregate_id", "category_id"], name: "index_aggregates_categories_on_aggregate_id_and_category_id"
  end

  create_table "aggregates_subcategories", id: false, force: :cascade do |t|
    t.integer "aggregate_id",   null: false
    t.integer "subcategory_id", null: false
    t.index ["aggregate_id", "subcategory_id"], name: "index_aggregates_subcategories_on_agg_sub_id"
  end

  create_table "aggregates_subcategories_tables", force: :cascade do |t|
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "folders", force: :cascade do |t|
    t.integer "folder_id"
    t.integer "content_id"
    t.index ["folder_id", "content_id"], name: "index_folders_on_folder_id_and_content_id", unique: true
  end

  create_table "subcategories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

end
