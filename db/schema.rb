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

ActiveRecord::Schema.define(version: 20180411204750) do

  create_table "activity_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_runtastic_id"
    t.bigint "activity_id"
    t.date "date"
    t.integer "activity_type"
    t.integer "duration"
    t.integer "distance"
    t.decimal "average_speed", precision: 5, scale: 2
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "activity_created_at"
    t.datetime "activity_updated_at"
    t.boolean "completed"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exercise_sport_id"
    t.index ["exercise_sport_id"], name: "index_activity_logs_on_exercise_sport_id"
    t.index ["user_runtastic_id"], name: "index_activity_logs_on_user_runtastic_id"
  end

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

  create_table "banking_movements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "exercise_id"
    t.string "reason"
    t.integer "time_after"
    t.integer "time_before"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_banking_movements_on_exercise_id"
    t.index ["user_id"], name: "index_banking_movements_on_user_id"
  end

  create_table "bet_option_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "bet_option_id"
    t.integer "time_bet", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bet_option_id"], name: "index_bet_option_users_on_bet_option_id"
    t.index ["user_id"], name: "index_bet_option_users_on_user_id"
  end

  create_table "bet_options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "bet_id"
    t.string "option"
    t.boolean "right_option", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bet_id"], name: "index_bet_options_on_bet_id"
  end

  create_table "bets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "bet"
    t.boolean "active", default: false
    t.boolean "open", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_check_points", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "admin_id"
    t.bigint "chatroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_chat_check_points_on_admin_id"
    t.index ["chatroom_id"], name: "index_chat_check_points_on_chatroom_id"
    t.index ["user_id"], name: "index_chat_check_points_on_user_id"
  end

  create_table "chatrooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "district_id"
    t.bigint "user_1_id"
    t.bigint "user_2_id"
    t.bigint "admin_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_chatrooms_on_admin_id"
    t.index ["district_id"], name: "index_chatrooms_on_district_id"
    t.index ["user_1_id"], name: "index_chatrooms_on_user_1_id"
    t.index ["user_2_id"], name: "index_chatrooms_on_user_2_id"
  end

  create_table "constants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "donations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.integer "seconds_donated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_donations_on_receiver_id"
    t.index ["sender_id"], name: "index_donations_on_sender_id"
  end

  create_table "exercise_benefit_scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "exercise_id"
    t.bigint "score_id"
    t.integer "time_benefit", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_benefit_scores_on_exercise_id"
    t.index ["score_id"], name: "index_exercise_benefit_scores_on_score_id"
  end

  create_table "exercise_options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "questionnaire_id"
    t.text "option"
    t.boolean "right", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_exercise_options_on_questionnaire_id"
  end

  create_table "exercise_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "exercise_id"
    t.bigint "user_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "second_file_updated_at"
    t.integer "second_file_file_size"
    t.string "second_file_content_type"
    t.string "second_file_file_name"
    t.integer "status", default: 0
    t.bigint "score_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_exercise_users_on_exercise_id"
    t.index ["user_id"], name: "index_exercise_users_on_user_id"
  end

  create_table "exercises", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type"
    t.text "title"
    t.text "statement"
    t.integer "time_benefit", default: 1
    t.boolean "district", default: false
    t.integer "time_cycling", default: 1
    t.integer "time_running", default: 1
    t.decimal "speed", precision: 12, scale: 6, default: "0.0"
    t.decimal "pace", precision: 12, scale: 6, default: "0.0"
    t.datetime "icon_updated_at"
    t.integer "icon_file_size"
    t.string "icon_content_type"
    t.string "icon_file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "feeding_type", default: 0
  end

  create_table "loans", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.integer "time_loan", default: 0
    t.integer "time_remaining", default: 0
    t.decimal "interest", precision: 12, scale: 6, default: "0.33"
    t.integer "share", default: 4
    t.integer "share_remaining"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "chatroom_id"
    t.bigint "user_id"
    t.bigint "admin_id"
    t.string "message", collation: "utf8_bin"
    t.boolean "viewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_messages_on_admin_id"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "privileges_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "card_file_name"
    t.string "card_content_type"
    t.integer "card_file_size"
    t.datetime "card_updated_at"
    t.string "title"
    t.text "description"
    t.integer "xp_cost"
    t.string "identifier"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rankings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "district_id"
    t.integer "position"
    t.integer "midchronic"
    t.boolean "classification", default: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_rankings_on_district_id"
    t.index ["user_id"], name: "index_rankings_on_user_id"
  end

  create_table "scores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.integer "time_benefit", default: 0
    t.string "icon_file_name"
    t.string "icon_content_type"
    t.integer "icon_file_size"
    t.datetime "icon_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweeters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tweeter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweeters_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "tweeter_id"
    t.index ["tweeter_id"], name: "index_tweeters_users_on_tweeter_id"
    t.index ["user_id"], name: "index_tweeters_users_on_user_id"
  end

  create_table "tweets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "twitter_backpacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "user_share_id"
    t.bigint "tweet_id"
    t.integer "backpack_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_twitter_backpacks_on_tweet_id"
    t.index ["user_id"], name: "index_twitter_backpacks_on_user_id"
    t.index ["user_share_id"], name: "index_twitter_backpacks_on_user_share_id"
  end

  create_table "user_privileges_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "privileges_card_id"
    t.bigint "user_id"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["privileges_card_id"], name: "index_user_privileges_cards_on_privileges_card_id"
    t.index ["user_id"], name: "index_user_privileges_cards_on_user_id"
  end

  create_table "user_ranges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "icon_file_name"
    t.string "icon_content_type"
    t.integer "icon_file_size"
    t.datetime "icon_updated_at"
    t.string "range_text"
    t.integer "min_score", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_runtastics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "runtastic_id"
    t.string "email"
    t.string "password"
    t.integer "age"
    t.boolean "alexa_integration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_runtastics_on_user_id"
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
    t.date "dob"
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
    t.datetime "tdv_holidays", default: "2018-03-26 18:25:54"
    t.integer "tdv_holidays_ref"
    t.datetime "tsc", default: "2017-12-29 00:00:00", null: false
    t.datetime "tsb", default: "2017-12-29 00:00:00", null: false
    t.integer "level", default: 0
    t.integer "xp", default: 0
    t.boolean "have_holidays", default: true
    t.boolean "untouchable", default: false, null: false
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["alias"], name: "index_users_on_alias"
    t.index ["district_id"], name: "index_users_on_district_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
