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

ActiveRecord::Schema.define(version: 2018_09_01_111332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string "asset_type"
    t.integer "value_per_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "balances", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "asset_id"
    t.decimal "amount", precision: 8, scale: 2
    t.integer "currency"
    t.index ["asset_id"], name: "index_balances_on_asset_id"
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "tref"
    t.integer "trx_type"
    t.decimal "amount", precision: 8, scale: 2
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "asset_id"
    t.integer "status", default: 0
    t.index ["asset_id"], name: "index_transactions_on_asset_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.integer "country"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
  end

  add_foreign_key "balances", "assets"
  add_foreign_key "balances", "users"
  add_foreign_key "transactions", "assets"
  add_foreign_key "transactions", "users"
end
