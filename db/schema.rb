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

ActiveRecord::Schema.define(version: 20160604024620) do
  create_table "addresses", force: :cascade do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "zip"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "household_limits", force: :cascade do |t|
    t.integer  "inventory_item_id"
    t.integer  "household_id"
    t.integer  "quantity"
    t.integer  "reset_after_days"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "household_limits", ["household_id"], name: "index_household_limits_on_household_id"
  add_index "household_limits", ["inventory_item_id"], name: "index_household_limits_on_inventory_item_id"

  create_table "households", force: :cascade do |t|
    t.string   "name"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "address_id"
    t.datetime "deleted_at"
  end

  add_index "households", ["deleted_at"], name: "index_households_on_deleted_at"

  create_table "inventory_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.string   "barcode"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "default_limit"
    t.integer  "limit_reset_after_days"
  end

  create_table "inventory_stock_records", force: :cascade do |t|
    t.integer  "itemid"
    t.integer  "quantity"
    t.date     "received"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inventory_visit_items", force: :cascade do |t|
    t.integer  "visitid"
    t.integer  "itemid"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "local_resource_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "local_resource_categories_resources", force: :cascade do |t|
    t.integer "local_resource_category_id"
    t.integer "local_resource_id"
  end

  create_table "local_resources", force: :cascade do |t|
    t.string   "business_name"
    t.string   "phone"
    t.string   "email"
    t.string   "url"
    t.integer  "address_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "phone_ext"
  end

  create_table "note_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: :cascade do |t|
    t.string   "note"
    t.integer  "note_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes_households", force: :cascade do |t|
    t.integer  "note_id"
    t.integer  "household_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "notes_people", force: :cascade do |t|
    t.integer  "note_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes_visits", force: :cascade do |t|
    t.integer  "note_id"
    t.integer  "visit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes_work_schedules", force: :cascade do |t|
    t.integer  "note_id"
    t.integer  "work_schedule_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_id"
    t.string   "email"
    t.datetime "deleted_at"
    t.string   "phone_ext"
  end

  add_index "people", ["deleted_at"], name: "index_people_on_deleted_at"

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "permissions", default: 0
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "person_id"
    t.string   "reset_email_token"
    t.datetime "reset_email_token_sent_at"
    t.string   "pending_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "visits", force: :cascade do |t|
    t.integer  "person_id"
    t.date     "visit_date"
    t.integer  "host_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_at"
    t.datetime "end_at"
  end

  create_table "work_schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end