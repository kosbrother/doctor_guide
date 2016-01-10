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

ActiveRecord::Schema.define(version: 20160110104607) do

  create_table "areas", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "intro",      limit: 65535
  end

  create_table "div_hosp_doc_ships", force: :cascade do |t|
    t.integer  "doctor_id",   limit: 4
    t.integer  "hospital_id", limit: 4
    t.integer  "division_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "div_hosp_doc_ships", ["division_id"], name: "index_div_hosp_doc_ships_on_division_id", using: :btree
  add_index "div_hosp_doc_ships", ["doctor_id"], name: "index_div_hosp_doc_ships_on_doctor_id", using: :btree
  add_index "div_hosp_doc_ships", ["hospital_id"], name: "index_div_hosp_doc_ships_on_hospital_id", using: :btree

  create_table "divisions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "divisions", ["category_id"], name: "index_divisions_on_category_id", using: :btree

  create_table "doctors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "address",    limit: 255
    t.text     "exp",        limit: 65535
    t.text     "spe",        limit: 65535
    t.string   "coUrl",      limit: 255
    t.string   "bUrl",       limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "area_id",    limit: 4
    t.decimal  "latitude",                 precision: 10, scale: 6
    t.decimal  "longitude",                precision: 10, scale: 6
  end

  add_index "doctors", ["area_id"], name: "index_doctors_on_area_id", using: :btree
  add_index "doctors", ["latitude"], name: "index_doctors_on_latitude", using: :btree
  add_index "doctors", ["longitude"], name: "index_doctors_on_longitude", using: :btree
  add_index "doctors", ["name"], name: "index_doctors_on_name", using: :btree

  create_table "hospitals", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "address",    limit: 255
    t.string   "grade",      limit: 255
    t.string   "assess",     limit: 255
    t.string   "nhiUrl",     limit: 255
    t.string   "code",       limit: 255
    t.string   "coUrl",      limit: 255
    t.boolean  "on"
    t.text     "cHours",     limit: 65535
    t.text     "ss",         limit: 65535
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "area_id",    limit: 4
    t.decimal  "latitude",                 precision: 10, scale: 6
    t.decimal  "longitude",                precision: 10, scale: 6
  end

  add_index "hospitals", ["area_id"], name: "index_hospitals_on_area_id", using: :btree
  add_index "hospitals", ["latitude"], name: "index_hospitals_on_latitude", using: :btree
  add_index "hospitals", ["longitude"], name: "index_hospitals_on_longitude", using: :btree
  add_index "hospitals", ["name"], name: "index_hospitals_on_name", using: :btree

end
