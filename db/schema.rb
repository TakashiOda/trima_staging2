# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_28_060037) do

  create_table "areas", force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "state_id", null: false
    t.integer "prefecture_id", null: false
    t.string "en_name"
    t.string "local_name"
    t.string "cn_name"
    t.string "tw_name"
    t.string "image"
    t.string "map"
    t.text "en_introduction"
    t.string "jp_introduction"
    t.string "cn_introduction"
    t.string "tw_introduction"
    t.string "nearest_airport"
    t.string "nearest_big_city"
    t.boolean "season_jan"
    t.boolean "season_feb"
    t.boolean "season_mar"
    t.boolean "season_apr"
    t.boolean "season_may"
    t.boolean "season_jun"
    t.boolean "season_jul"
    t.boolean "season_aug"
    t.boolean "season_sep"
    t.boolean "season_oct"
    t.boolean "season_nov"
    t.boolean "season_dec"
    t.index ["country_id"], name: "index_areas_on_country_id"
    t.index ["prefecture_id"], name: "index_areas_on_prefecture_id"
    t.index ["state_id"], name: "index_areas_on_state_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "apply_lang"
  end

  create_table "prefectures", force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "state_id", null: false
    t.string "en_name"
    t.string "local_name"
    t.string "cn_name"
    t.string "tw_name"
    t.index ["country_id"], name: "index_prefectures_on_country_id"
    t.index ["state_id"], name: "index_prefectures_on_state_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "owner_user_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "start_place"
    t.string "end_place"
    t.integer "destination_area_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["destination_area_id"], name: "index_projects_on_destination_area_id"
    t.index ["owner_user_id"], name: "index_projects_on_owner_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "en_name"
    t.string "local_name"
    t.string "cn_name"
    t.string "tw_name"
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.string "control_level", default: "owner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.text "profile_text"
    t.integer "country_id"
    t.integer "language_id"
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_day"
    t.string "gender"
    t.string "avatar"
    t.string "phone"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "areas", "countries"
  add_foreign_key "areas", "prefectures"
  add_foreign_key "areas", "states"
  add_foreign_key "prefectures", "countries"
  add_foreign_key "prefectures", "states"
  add_foreign_key "projects", "areas", column: "destination_area_id"
  add_foreign_key "projects", "users", column: "owner_user_id"
  add_foreign_key "states", "countries"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "users"
end
