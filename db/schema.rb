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

ActiveRecord::Schema.define(version: 20160907065135) do

  create_table "admins", force: :cascade do |t|
    t.string   "username",   limit: 255
    t.string   "password",   limit: 255
    t.integer  "status",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "fullname",   limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.string   "email",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "status",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "description", limit: 255
    t.text     "content",     limit: 65535
    t.integer  "status",      limit: 4
    t.integer  "type",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "code",         limit: 255
    t.string   "value",        limit: 255
    t.string   "deadline",     limit: 255
    t.integer  "status",       limit: 4
    t.integer  "paid",         limit: 8
    t.integer  "penance",      limit: 8
    t.integer  "debt",         limit: 8
    t.integer  "drawdowns_id", limit: 4
    t.string   "loans_time",   limit: 255
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "contracts", ["user_id"], name: "index_contracts_on_user_id", using: :btree

  create_table "drawdowns", force: :cascade do |t|
    t.integer  "sponsor_id",         limit: 4
    t.string   "contract_date",      limit: 255
    t.integer  "media_contract_id",  limit: 4
    t.string   "contract_time",      limit: 255
    t.integer  "position",           limit: 4
    t.integer  "media_appoint_id",   limit: 4
    t.integer  "appoint_in_contact", limit: 4
    t.integer  "salary",             limit: 8
    t.integer  "media_salary_id",    limit: 4
    t.integer  "amount",             limit: 4
    t.string   "amount_time",        limit: 255
    t.string   "purpose",            limit: 255
    t.string   "pay_time",           limit: 255
    t.string   "account_holders",    limit: 255
    t.string   "account_number",     limit: 255
    t.integer  "bank_id",            limit: 4
    t.integer  "branch_id",          limit: 4
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "is_draft",           limit: 4,   default: 0
  end

  create_table "histories", force: :cascade do |t|
    t.integer  "contract_id",     limit: 4
    t.integer  "status_contract", limit: 4
    t.datetime "created_at",                null: false
    t.integer  "summery",         limit: 8
    t.integer  "orgin_rate",      limit: 8
    t.integer  "interest_rate",   limit: 8
    t.datetime "updated_at",                null: false
    t.integer  "user_id",         limit: 4
  end

  add_index "histories", ["contract_id"], name: "index_histories_on_contract_id", using: :btree

  create_table "media", force: :cascade do |t|
    t.string   "path",              limit: 255
    t.integer  "id_item",           limit: 4
    t.integer  "type",              limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "path_file_name",    limit: 255
    t.string   "path_content_type", limit: 255
    t.integer  "path_file_size",    limit: 4
    t.datetime "path_updated_at"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.string   "content",    limit: 255
    t.integer  "is_read",    limit: 4
    t.integer  "type",       limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "provinces", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sliders", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sponsors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email_old",              limit: 255
    t.string   "password",               limit: 255
    t.string   "active_code",            limit: 255
    t.integer  "status",                 limit: 4
    t.integer  "count_login_fail",       limit: 4,   default: 0
    t.string   "birthday",               limit: 255
    t.integer  "by_social",              limit: 4,   default: 0
    t.string   "facebook_id",            limit: 255
    t.string   "google_id",              limit: 255
    t.integer  "change_email",           limit: 4,   default: 1
    t.string   "passport",               limit: 255
    t.integer  "media_id",               limit: 4
    t.integer  "gender",                 limit: 4
    t.string   "phone",                  limit: 255
    t.string   "address",                limit: 255
    t.integer  "provined_id",            limit: 4
    t.integer  "district_id",            limit: 4
    t.integer  "ward_id",                limit: 4
    t.string   "storage_time",           limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "oauth_token",            limit: 255
    t.datetime "oauth_expires_at"
    t.string   "name",                   limit: 255
    t.integer  "marriage",               limit: 4,   default: 0
    t.string   "expired_time",           limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_foreign_key "contracts", "users"
  add_foreign_key "histories", "contracts"
  add_foreign_key "notifications", "users"
end
