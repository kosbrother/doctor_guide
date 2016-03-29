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

ActiveRecord::Schema.define(version: 20160329115637) do

  create_table "add_doctors", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "hospital_name", limit: 255
    t.string   "division_name", limit: 255
    t.string   "spe",           limit: 255
    t.string   "exp",           limit: 255
    t.integer  "hospital_id",   limit: 4
    t.integer  "division_id",   limit: 4
    t.boolean  "is_checked",                default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "areas", force: :cascade do |t|
    t.string  "name",      limit: 255
    t.decimal "latitude",              precision: 10, scale: 6
    t.decimal "longitude",             precision: 10, scale: 6
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "intro",      limit: 65535
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "dr_friendly",     limit: 4
    t.integer  "dr_speciality",   limit: 4
    t.integer  "div_equipment",   limit: 4
    t.integer  "div_environment", limit: 4
    t.integer  "div_speciality",  limit: 4
    t.integer  "div_friendly",    limit: 4
    t.integer  "doctor_id",       limit: 4
    t.integer  "hospital_id",     limit: 4
    t.integer  "division_id",     limit: 4
    t.text     "div_comment",     limit: 65535
    t.text     "dr_comment",      limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "is_recommend"
    t.integer  "user_id",         limit: 4
  end

  add_index "comments", ["division_id"], name: "index_comments_on_division_id", using: :btree
  add_index "comments", ["doctor_id"], name: "index_comments_on_doctor_id", using: :btree
  add_index "comments", ["hospital_id"], name: "index_comments_on_hospital_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

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
    t.string   "name",          limit: 255
    t.string   "phone",         limit: 255
    t.string   "address",       limit: 255
    t.text     "exp",           limit: 65535
    t.text     "spe",           limit: 65535
    t.string   "coUrl",         limit: 255
    t.string   "bUrl",          limit: 255
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "area_id",       limit: 4
    t.decimal  "latitude",                    precision: 10, scale: 6
    t.decimal  "longitude",                   precision: 10, scale: 6
    t.integer  "comment_num",   limit: 4
    t.integer  "recommend_num", limit: 4
    t.decimal  "avg",                         precision: 10, scale: 6
  end

  add_index "doctors", ["area_id"], name: "index_doctors_on_area_id", using: :btree
  add_index "doctors", ["avg"], name: "index_doctors_on_avg", using: :btree
  add_index "doctors", ["comment_num"], name: "index_doctors_on_comment_num", using: :btree
  add_index "doctors", ["latitude"], name: "index_doctors_on_latitude", using: :btree
  add_index "doctors", ["longitude"], name: "index_doctors_on_longitude", using: :btree
  add_index "doctors", ["name"], name: "index_doctors_on_name", using: :btree
  add_index "doctors", ["recommend_num"], name: "index_doctors_on_recommend_num", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string   "subject",    limit: 255
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "hospitals", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "phone",         limit: 255
    t.string   "address",       limit: 255
    t.string   "grade",         limit: 255
    t.string   "assess",        limit: 255
    t.string   "nhiUrl",        limit: 255
    t.string   "code",          limit: 255
    t.string   "coUrl",         limit: 255
    t.boolean  "on"
    t.text     "cHours",        limit: 65535
    t.text     "ss",            limit: 65535
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "area_id",       limit: 4
    t.decimal  "latitude",                    precision: 10, scale: 6
    t.decimal  "longitude",                   precision: 10, scale: 6
    t.integer  "comment_num",   limit: 4
    t.integer  "recommend_num", limit: 4
    t.decimal  "avg",                         precision: 10, scale: 6
    t.string   "slug",          limit: 255
  end

  add_index "hospitals", ["area_id"], name: "index_hospitals_on_area_id", using: :btree
  add_index "hospitals", ["avg"], name: "index_hospitals_on_avg", using: :btree
  add_index "hospitals", ["comment_num"], name: "index_hospitals_on_comment_num", using: :btree
  add_index "hospitals", ["latitude"], name: "index_hospitals_on_latitude", using: :btree
  add_index "hospitals", ["longitude"], name: "index_hospitals_on_longitude", using: :btree
  add_index "hospitals", ["name"], name: "index_hospitals_on_name", using: :btree
  add_index "hospitals", ["recommend_num"], name: "index_hospitals_on_recommend_num", using: :btree
  add_index "hospitals", ["slug"], name: "index_hospitals_on_slug", unique: true, using: :btree

  create_table "problems", force: :cascade do |t|
    t.text     "content",     limit: 65535
    t.integer  "doctor_id",   limit: 4
    t.integer  "hospital_id", limit: 4
    t.integer  "division_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "pic_url",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "app_id",     limit: 255
  end

  add_index "users", ["app_id"], name: "index_users_on_app_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
