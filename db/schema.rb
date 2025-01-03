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

ActiveRecord::Schema[8.0].define(version: 2024_09_12_024141) do
  create_table "accesses", force: :cascade do |t|
    t.string "level", null: false
    t.integer "user_id", null: false
    t.integer "patient_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_record_id"], name: "index_accesses_on_patient_record_id"
    t.index ["user_id", "patient_record_id"], name: "index_accesses_on_user_id_and_patient_record_id", unique: true
    t.index ["user_id"], name: "index_accesses_on_user_id"
  end

  create_table "administratorships", force: :cascade do |t|
    t.integer "role"
    t.integer "user_id", null: false
    t.integer "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_administratorships_on_organization_id"
    t.index ["user_id"], name: "index_administratorships_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.boolean "active", default: true
    t.string "uid", null: false
    t.string "join_code", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["join_code"], name: "index_organizations_on_join_code", unique: true
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
    t.index ["uid"], name: "index_organizations_on_uid", unique: true
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "patient_records", force: :cascade do |t|
    t.string "name", null: false
    t.string "email_address", null: false
    t.datetime "date", null: false
    t.string "procedure"
    t.integer "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_patient_records_on_organization_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.decimal "cost", precision: 10, scale: 2, null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_services_on_organization_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.integer "role", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "administratorships", "organizations"
  add_foreign_key "administratorships", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "patient_records", "organizations"
  add_foreign_key "sessions", "users"
end
