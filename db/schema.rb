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

ActiveRecord::Schema.define(version: 2021_04_15_093117) do

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "birthday"
    t.string "phone"
    t.string "address"
    t.string "credit_card"
    t.string "franchise"
    t.string "email"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "last_digits"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "failed_contacts", force: :cascade do |t|
    t.string "name"
    t.string "birthday"
    t.string "phone"
    t.string "address"
    t.string "credit_card"
    t.string "franchise"
    t.string "last_digits"
    t.string "email"
    t.text "error"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_failed_contacts_on_user_id"
  end

  create_table "import_files", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "filename"
    t.string "status"
    t.string "import_errors"
    t.string "state"
    t.index ["user_id"], name: "index_import_files_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "failed_contacts", "users"
  add_foreign_key "import_files", "users"
end
