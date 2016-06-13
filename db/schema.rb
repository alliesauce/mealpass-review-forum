# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160612221837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["comment_id"], name: "index_comments_on_comment_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "meals", force: :cascade do |t|
    t.string  "name",          limit: 50
    t.string  "description",   limit: 300
    t.integer "vote_count"
    t.integer "restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name",           limit: 50
    t.string "raw_address",    limit: 150
    t.string "google_map_url", limit: 150
    t.float  "lat"
    t.float  "lng"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "meal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["meal_id"], name: "index_reviews_on_meal_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",        limit: 150
    t.string   "last_name",         limit: 150
    t.string   "username",          limit: 150
    t.string   "password_digest",   limit: 150
    t.string   "email",             limit: 150
    t.boolean  "admin"
    t.string   "reset_digest",      limit: 150
    t.datetime "reset_sent_at"
    t.string   "activation_digest", limit: 150
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "remember_digest",   limit: 150
    t.text     "about_me"
  end

  add_foreign_key "comments", "comments"
  add_foreign_key "comments", "users"
  add_foreign_key "reviews", "meals"
  add_foreign_key "reviews", "users"
end
