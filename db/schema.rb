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

ActiveRecord::Schema.define(version: 2020_11_07_031852) do

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.integer "activity_business_id", null: false
    t.integer "activity_category_id", null: false
    t.text "description"
    t.text "notes"
    t.string "main_image"
    t.string "second_image"
    t.string "third_image"
    t.string "fourth_image"
    t.integer "activity_minutes"
    t.integer "prefecture_id"
    t.integer "area_id"
    t.integer "town_id"
    t.string "detail_address"
    t.string "building"
    t.float "longitude"
    t.float "latitude"
    t.string "meeting_spot1_japanese_address"
    t.text "meeting_spot1_japanese_description"
    t.float "meeting_spot1_longitude"
    t.float "meeting_spot1_latitude"
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
    t.boolean "is_all_year_open", default: true
    t.date "start_date"
    t.date "end_date"
    t.integer "normal_adult_price"
    t.boolean "has_season_price", default: false
    t.boolean "monday_open", default: true
    t.boolean "tuesday_open", default: true
    t.boolean "wednesday_open", default: true
    t.boolean "thursday_open", default: true
    t.boolean "friday_open", default: true
    t.boolean "saturday_open", default: true
    t.boolean "sunday_open", default: true
    t.boolean "rain_or_shine", default: false
    t.boolean "advertise_activate", default: false
    t.string "status", default: "draft"
    t.boolean "is_approved", default: false
    t.boolean "stop_now", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["activity_business_id"], name: "index_activities_on_activity_business_id"
    t.index ["advertise_activate"], name: "index_activities_on_advertise_activate"
    t.index ["april"], name: "index_activities_on_april"
    t.index ["area_id"], name: "index_activities_on_area_id"
    t.index ["august"], name: "index_activities_on_august"
    t.index ["available_age"], name: "index_activities_on_available_age"
    t.index ["december"], name: "index_activities_on_december"
    t.index ["end_date"], name: "index_activities_on_end_date"
    t.index ["febrary"], name: "index_activities_on_febrary"
    t.index ["is_all_year_open"], name: "index_activities_on_is_all_year_open"
    t.index ["is_approved"], name: "index_activities_on_is_approved"
    t.index ["january"], name: "index_activities_on_january"
    t.index ["july"], name: "index_activities_on_july"
    t.index ["june"], name: "index_activities_on_june"
    t.index ["march"], name: "index_activities_on_march"
    t.index ["maximum_num"], name: "index_activities_on_maximum_num"
    t.index ["may"], name: "index_activities_on_may"
    t.index ["november"], name: "index_activities_on_november"
    t.index ["october"], name: "index_activities_on_october"
    t.index ["prefecture_id"], name: "index_activities_on_prefecture_id"
    t.index ["september"], name: "index_activities_on_september"
    t.index ["start_date"], name: "index_activities_on_start_date"
    t.index ["stop_now"], name: "index_activities_on_stop_now"
    t.index ["town_id"], name: "index_activities_on_town_id"
  end

  create_table "activity_ageprices", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "age_from", default: 0, null: false
    t.integer "age_to", default: 100, null: false
    t.integer "normal_price", default: 1000, null: false
    t.integer "high_price", default: 1000, null: false
    t.integer "low_price", default: 1000, null: false
    t.index ["activity_id"], name: "index_activity_ageprices_on_activity_id"
  end

  create_table "activity_businesses", force: :cascade do |t|
    t.integer "supplier_id", null: false
    t.string "profile_image"
    t.string "name"
    t.string "en_name"
    t.string "cn_name"
    t.string "tw_name"
    t.text "profile_text"
    t.text "en_profile_text"
    t.text "cn_profile_text"
    t.text "tw_profile_text"
    t.boolean "apply_suuplier_address", default: true
    t.boolean "apply_suuplier_phone", default: true
    t.string "post_code"
    t.integer "prefecture_id"
    t.integer "area_id"
    t.integer "town_id"
    t.string "detail_address"
    t.string "building"
    t.string "phone"
    t.string "no_charge_cansel_before", default: "three_days_before"
    t.boolean "has_insurance", default: false
    t.string "guide_certification"
    t.boolean "is_approved", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_activity_businesses_on_area_id"
    t.index ["guide_certification"], name: "index_activity_businesses_on_guide_certification"
    t.index ["has_insurance"], name: "index_activity_businesses_on_has_insurance"
    t.index ["is_approved"], name: "index_activity_businesses_on_is_approved"
    t.index ["prefecture_id"], name: "index_activity_businesses_on_prefecture_id"
    t.index ["supplier_id"], name: "index_activity_businesses_on_supplier_id"
    t.index ["town_id"], name: "index_activity_businesses_on_town_id"
  end

  create_table "activity_categories", force: :cascade do |t|
    t.string "en_name"
    t.string "jp_name"
    t.string "cn_name"
  end

  create_table "activity_courses", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.time "start_time"
    t.index ["activity_id", "start_time"], name: "index_activity_courses_on_activity_id_and_start_time", unique: true
    t.index ["activity_id"], name: "index_activity_courses_on_activity_id"
  end

  create_table "activity_languages", force: :cascade do |t|
    t.integer "activity_business_id", null: false
    t.integer "language_id", null: false
    t.index ["activity_business_id", "language_id"], name: "activity_languages_unique_index", unique: true
    t.index ["activity_business_id"], name: "index_activity_languages_on_activity_business_id"
    t.index ["language_id"], name: "index_activity_languages_on_language_id"
  end

  create_table "activity_stocks", force: :cascade do |t|
    t.integer "activity_course_id", null: false
    t.integer "activity_id", null: false
    t.date "date"
    t.integer "stock", default: 0
    t.integer "book_amount", default: 0, null: false
    t.string "season_price", default: "normal"
    t.index ["activity_course_id", "date"], name: "index_activity_stocks_on_activity_course_id_and_date", unique: true
    t.index ["activity_course_id"], name: "index_activity_stocks_on_activity_course_id"
    t.index ["date"], name: "index_activity_stocks_on_date"
    t.index ["stock"], name: "index_activity_stocks_on_stock"
  end

  create_table "activity_translations", force: :cascade do |t|
    t.integer "activity_id", null: false
    t.integer "language_id"
    t.string "name"
    t.text "profile_text"
    t.text "notes"
    t.index ["activity_id", "language_id"], name: "activity_translation_unique_index", unique: true
    t.index ["activity_id"], name: "index_activity_translations_on_activity_id"
  end

  create_table "areas", force: :cascade do |t|
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
    t.index ["prefecture_id"], name: "index_areas_on_prefecture_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
  end

  create_table "guides", force: :cascade do |t|
    t.integer "activity_business_id", null: false
    t.string "name"
    t.string "avatar"
    t.text "introduction"
    t.string "roll"
    t.boolean "speak_japanese", default: true
    t.boolean "speak_english", default: false
    t.boolean "speak_chinese", default: false
    t.string "other_language"
    t.boolean "stop_now", default: false
    t.index ["activity_business_id"], name: "index_guides_on_activity_business_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "apply_lang"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "en_name"
    t.string "local_name"
    t.string "cn_name"
    t.string "tw_name"
    t.text "en_introduction"
    t.text "jp_introduction"
    t.text "cn_introduction"
    t.text "tw_introduction"
    t.string "image"
  end

  create_table "project_areas", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "area_id", null: false
    t.index ["area_id"], name: "index_project_areas_on_area_id"
    t.index ["project_id", "area_id"], name: "index_project_areas_on_project_id_and_area_id", unique: true
    t.index ["project_id"], name: "index_project_areas_on_project_id"
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
    t.string "icon", default: "project_icon-01"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "supplier_applies", force: :cascade do |t|
    t.string "company"
    t.string "name"
    t.integer "prefecture"
    t.integer "town"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.boolean "agree_term", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "supplier_profiles", force: :cascade do |t|
    t.integer "supplier_id", null: false
    t.string "manager_name"
    t.string "post_code"
    t.integer "prefecture_id"
    t.integer "area_id"
    t.integer "town_id"
    t.string "detail_address"
    t.string "building"
    t.string "phone"
    t.integer "contract_plan", default: 0, null: false
    t.boolean "is_suspended", default: false, null: false
    t.index ["supplier_id"], name: "index_supplier_profiles_on_supplier_id"
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
    t.index ["confirmation_token"], name: "index_suppliers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_suppliers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_suppliers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_suppliers_on_unlock_token", unique: true
  end

  create_table "towns", force: :cascade do |t|
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
    t.index ["en_name"], name: "index_towns_on_en_name"
    t.index ["jp_name"], name: "index_towns_on_jp_name"
    t.index ["prefecture_id"], name: "index_towns_on_prefecture_id"
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
  add_foreign_key "activity_ageprices", "activities"
  add_foreign_key "activity_businesses", "suppliers"
  add_foreign_key "activity_courses", "activities"
  add_foreign_key "activity_languages", "activity_businesses"
  add_foreign_key "activity_languages", "languages"
  add_foreign_key "activity_stocks", "activity_courses"
  add_foreign_key "activity_translations", "activities"
  add_foreign_key "areas", "prefectures"
  add_foreign_key "guides", "activity_businesses"
  add_foreign_key "project_areas", "areas"
  add_foreign_key "project_areas", "projects"
  add_foreign_key "project_invites", "projects"
  add_foreign_key "project_invites", "users", column: "inviter_id"
  add_foreign_key "supplier_profiles", "suppliers"
  add_foreign_key "towns", "areas"
  add_foreign_key "towns", "prefectures"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "users"
end
