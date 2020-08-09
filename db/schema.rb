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

ActiveRecord::Schema.define(version: 2020_08_08_085301) do

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.integer "activity_business_id", null: false
    t.integer "activity_category_id", null: false
    t.text "description"
    t.string "main_image"
    t.integer "state_id"
    t.integer "prefecture_id"
    t.integer "area_id"
    t.integer "town_id"
    t.string "detail_address"
    t.string "building"
    t.float "longitude"
    t.float "latitude"
    t.integer "maximum_num", default: 1
    t.integer "minimum_num", default: 5
    t.integer "available_age", default: 6
    t.boolean "january", default: true
    t.boolean "febrary", default: true
    t.boolean "march", default: true
    t.boolean "april", default: true
    t.boolean "may", default: true
    t.boolean "june", default: true
    t.boolean "july", default: true
    t.boolean "august", default: true
    t.boolean "september", default: true
    t.boolean "october", default: true
    t.boolean "november", default: true
    t.boolean "december", default: true
    t.boolean "advertise_activate", default: false
    t.boolean "is_approved", default: false
    t.index ["activity_business_id"], name: "index_activities_on_activity_business_id"
    t.index ["activity_category_id"], name: "index_activities_on_activity_category_id"
    t.index ["advertise_activate"], name: "index_activities_on_advertise_activate"
    t.index ["april"], name: "index_activities_on_april"
    t.index ["area_id"], name: "index_activities_on_area_id"
    t.index ["august"], name: "index_activities_on_august"
    t.index ["available_age"], name: "index_activities_on_available_age"
    t.index ["december"], name: "index_activities_on_december"
    t.index ["febrary"], name: "index_activities_on_febrary"
    t.index ["is_approved"], name: "index_activities_on_is_approved"
    t.index ["january"], name: "index_activities_on_january"
    t.index ["july"], name: "index_activities_on_july"
    t.index ["june"], name: "index_activities_on_june"
    t.index ["march"], name: "index_activities_on_march"
    t.index ["may"], name: "index_activities_on_may"
    t.index ["november"], name: "index_activities_on_november"
    t.index ["october"], name: "index_activities_on_october"
    t.index ["prefecture_id"], name: "index_activities_on_prefecture_id"
    t.index ["september"], name: "index_activities_on_september"
    t.index ["state_id"], name: "index_activities_on_state_id"
    t.index ["town_id"], name: "index_activities_on_town_id"
  end

  create_table "activity_businesses", force: :cascade do |t|
    t.integer "organization_id", null: false
    t.string "name"
    t.string "profile_image"
    t.text "profile_text"
    t.integer "state_id"
    t.integer "prefecture_id"
    t.integer "area_id"
    t.integer "town_id"
    t.string "detail_address"
    t.string "building"
    t.boolean "apply_org_info", default: true
    t.boolean "apply_org_bank", default: true
    t.boolean "has_insurance", default: false
    t.string "guide_certification"
    t.boolean "is_approved", default: false
    t.index ["area_id"], name: "index_activity_businesses_on_area_id"
    t.index ["guide_certification"], name: "index_activity_businesses_on_guide_certification"
    t.index ["has_insurance"], name: "index_activity_businesses_on_has_insurance"
    t.index ["is_approved"], name: "index_activity_businesses_on_is_approved"
    t.index ["organization_id"], name: "index_activity_businesses_on_organization_id"
    t.index ["prefecture_id"], name: "index_activity_businesses_on_prefecture_id"
    t.index ["state_id"], name: "index_activity_businesses_on_state_id"
    t.index ["town_id"], name: "index_activity_businesses_on_town_id"
  end

  create_table "activity_categories", force: :cascade do |t|
    t.string "en_name"
    t.string "jp_name"
    t.string "cn_name"
  end

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
    t.text "jp_introduction"
    t.text "cn_introduction"
    t.text "tw_introduction"
    t.string "nearest_airport"
    t.string "nearest_big_city"
    t.boolean "season_jan", default: false, null: false
    t.boolean "season_feb", default: false, null: false
    t.boolean "season_mar", default: false, null: false
    t.boolean "season_apr", default: false, null: false
    t.boolean "season_may", default: false, null: false
    t.boolean "season_jun", default: false, null: false
    t.boolean "season_jul", default: false, null: false
    t.boolean "season_aug", default: false, null: false
    t.boolean "season_sep", default: false, null: false
    t.boolean "season_oct", default: false, null: false
    t.boolean "season_nov", default: false, null: false
    t.boolean "season_dec", default: false, null: false
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

  create_table "org_invites", force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "inviter_id"
    t.string "invited_email"
    t.integer "accept_invite", default: 1
    t.integer "has_account", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inviter_id"], name: "index_org_invites_on_inviter_id"
    t.index ["organization_id"], name: "index_org_invites_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "org_type"
    t.string "name", null: false
    t.integer "state_id"
    t.integer "prefecture_id"
    t.integer "town_id"
    t.string "detail_address"
    t.string "building"
    t.string "post_code"
    t.string "phone"
    t.boolean "has_event", default: false, null: false
    t.boolean "has_spot", default: false, null: false
    t.boolean "has_activity", default: false, null: false
    t.boolean "has_restaurant", default: false, null: false
    t.integer "contract_plan", default: 0, null: false
    t.integer "contract_status", default: 1, null: false
    t.index ["contract_plan"], name: "index_organizations_on_contract_plan"
    t.index ["contract_status"], name: "index_organizations_on_contract_status"
    t.index ["phone"], name: "index_organizations_on_phone"
    t.index ["prefecture_id"], name: "index_organizations_on_prefecture_id"
    t.index ["state_id"], name: "index_organizations_on_state_id"
    t.index ["town_id"], name: "index_organizations_on_town_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "state_id", null: false
    t.string "en_name"
    t.string "local_name"
    t.string "cn_name"
    t.string "tw_name"
    t.text "en_introduction"
    t.text "jp_introduction"
    t.text "cn_introduction"
    t.text "tw_introduction"
    t.string "image"
    t.index ["country_id"], name: "index_prefectures_on_country_id"
    t.index ["state_id"], name: "index_prefectures_on_state_id"
  end

  create_table "project_invites", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "inviter_id"
    t.string "invited_email"
    t.integer "accept_invite", default: 1
    t.integer "has_account", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invited_email"], name: "index_project_invites_on_invited_email"
    t.index ["inviter_id"], name: "index_project_invites_on_inviter_id"
    t.index ["project_id"], name: "index_project_invites_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.string "start_place"
    t.string "end_place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "states", force: :cascade do |t|
    t.integer "country_id", null: false
    t.string "en_name"
    t.string "local_name"
    t.string "cn_name"
    t.string "tw_name"
    t.text "en_introduction"
    t.text "jp_introduction"
    t.text "cn_introduction"
    t.text "tw_introduction"
    t.string "image"
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "suppliers", force: :cascade do |t|
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
    t.string "name"
    t.string "avatar"
    t.integer "organization_id"
    t.integer "control_level", default: 0, null: false
    t.integer "accept_invite", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_suppliers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_suppliers_on_email", unique: true
    t.index ["organization_id"], name: "index_suppliers_on_organization_id"
    t.index ["reset_password_token"], name: "index_suppliers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_suppliers_on_unlock_token", unique: true
  end

  create_table "towns", force: :cascade do |t|
    t.string "town_code"
    t.integer "country_id", null: false
    t.integer "state_id", null: false
    t.integer "prefecture_id", null: false
    t.integer "area_id", null: false
    t.string "en_name"
    t.string "jp_name"
    t.string "cn_name"
    t.string "tw_name"
    t.text "en_introduction"
    t.text "jp_introduction"
    t.text "cn_introduction"
    t.text "tw_introduction"
    t.boolean "is_big_city"
    t.string "image"
    t.index ["area_id"], name: "index_towns_on_area_id"
    t.index ["cn_name"], name: "index_towns_on_cn_name"
    t.index ["country_id"], name: "index_towns_on_country_id"
    t.index ["en_name"], name: "index_towns_on_en_name"
    t.index ["jp_name"], name: "index_towns_on_jp_name"
    t.index ["prefecture_id"], name: "index_towns_on_prefecture_id"
    t.index ["state_id"], name: "index_towns_on_state_id"
    t.index ["town_code"], name: "index_towns_on_town_code"
    t.index ["tw_name"], name: "index_towns_on_tw_name"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.integer "control_level", default: 0
    t.integer "accept_invite", default: 0
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["user_id", "project_id"], name: "index_user_projects_on_user_id_and_project_id", unique: true
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

  add_foreign_key "activities", "activity_businesses"
  add_foreign_key "activities", "activity_categories"
  add_foreign_key "activity_businesses", "organizations"
  add_foreign_key "areas", "countries"
  add_foreign_key "areas", "prefectures"
  add_foreign_key "areas", "states"
  add_foreign_key "org_invites", "organizations"
  add_foreign_key "org_invites", "suppliers", column: "inviter_id"
  add_foreign_key "prefectures", "countries"
  add_foreign_key "prefectures", "states"
  add_foreign_key "project_invites", "projects"
  add_foreign_key "project_invites", "users", column: "inviter_id"
  add_foreign_key "states", "countries"
  add_foreign_key "suppliers", "organizations"
  add_foreign_key "towns", "areas"
  add_foreign_key "towns", "countries"
  add_foreign_key "towns", "prefectures"
  add_foreign_key "towns", "states"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "users"
end
