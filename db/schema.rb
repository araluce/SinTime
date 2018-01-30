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

ActiveRecord::Schema.define(version: 20180130194754) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "avatar_updated_at"
    t.integer "avatar_file_size"
    t.string "avatar_content_type"
    t.string "avatar_file_name"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "districts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "logo_updated_at"
    t.integer "logo_file_size"
    t.string "logo_content_type"
    t.string "logo_file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercise_options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "questionnaire_id"
    t.text "option"
    t.boolean "right", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_exercise_options_on_questionnaire_id"
  end

  create_table "exercises", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.text "statement"
    t.integer "time_benefit", default: 1
    t.integer "time_cycling", default: 1
    t.integer "time_running", default: 1
    t.decimal "running_rate", precision: 12, scale: 6, default: "0.0"
    t.decimal "cycling_rate", precision: 12, scale: 6, default: "0.0"
    t.datetime "icon_updated_at"
    t.integer "icon_file_size"
    t.string "icon_content_type"
    t.string "icon_file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "feeding_type", default: 0
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "avatar_updated_at"
    t.integer "avatar_file_size"
    t.string "avatar_content_type"
    t.string "avatar_file_name"
    t.string "name"
    t.string "lastname"
    t.string "dni"
    t.string "alias"
    t.bigint "district_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "status", default: 0, null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.boolean "logged", default: false, null: false
    t.datetime "tdv", default: "2018-01-13 00:00:00", null: false
    t.datetime "tsc", default: "2017-12-29 00:00:00", null: false
    t.datetime "tsb", default: "2017-12-29 00:00:00", null: false
    t.boolean "untouchable", default: false, null: false
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["alias"], name: "index_users_on_alias"
    t.index ["district_id"], name: "index_users_on_district_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
