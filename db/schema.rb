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

ActiveRecord::Schema.define(version: 20171022204620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts_of_people", id: false, force: :cascade do |t|
    t.integer "social_media_account_id", null: false
    t.integer "person_id",               null: false
    t.index ["person_id"], name: "index_accounts_of_people_on_person_id", using: :btree
    t.index ["social_media_account_id"], name: "index_accounts_of_people_on_social_media_account_id", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "two_digit_code"
    t.string   "three_digit_code"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lists_of_people", id: false, force: :cascade do |t|
    t.integer "list_id",   null: false
    t.integer "person_id", null: false
    t.index ["list_id"], name: "index_lists_of_people_on_list_id", using: :btree
    t.index ["person_id"], name: "index_lists_of_people_on_person_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "street_number"
    t.string   "street"
    t.string   "zip_code"
    t.string   "state"
    t.string   "city"
    t.string   "phone"
    t.string   "cellphone"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "country_id"
    t.index ["country_id"], name: "index_people_on_country_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "posted_at"
    t.string   "content"
    t.string   "url"
    t.string   "original_url"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "person_id",               null: false
    t.integer  "social_media_account_id", null: false
    t.index ["person_id"], name: "index_posts_on_person_id", using: :btree
    t.index ["social_media_account_id"], name: "index_posts_on_social_media_account_id", using: :btree
  end

  create_table "social_media_accounts", force: :cascade do |t|
    t.string   "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "social_media_type_id", null: false
    t.index ["social_media_type_id"], name: "index_social_media_accounts_on_social_media_type_id", using: :btree
  end

  create_table "social_media_types", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "people", "countries"
  add_foreign_key "posts", "people"
  add_foreign_key "posts", "social_media_accounts"
  add_foreign_key "social_media_accounts", "social_media_types"
end
