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

ActiveRecord::Schema.define(version: 20131202224331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "fraud_fields", force: true do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fraud_type_id"
  end

  create_table "fraud_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frauds", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "fraud_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fraud_type_id"
    t.hstore   "properties"
    t.string   "status",        default: "1"
  end

  add_index "frauds", ["properties"], name: "frauds_properties_idx", using: :gin

  create_table "images", force: true do |t|
    t.string   "image"
    t.integer  "fraud_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "provider"
  end

end
