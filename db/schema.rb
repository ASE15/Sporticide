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

ActiveRecord::Schema.define(version: 20151029103231) do

  create_table "chats", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partner_id"
  end

  add_index "chats", ["partner_id"], name: "index_chats_on_partner_id"
  add_index "chats", ["user_id"], name: "index_chats_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.datetime "datetime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "training_id"
  end

  add_index "comments", ["training_id"], name: "index_comments_on_training_id"

  create_table "friend_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "friend_id"
  end

  add_index "friend_requests", ["friend_id"], name: "index_friend_requests_on_friend_id"
  add_index "friend_requests", ["user_id"], name: "index_friend_requests_on_user_id"

  create_table "friends", id: false, force: :cascade do |t|
    t.integer "user_a_id", null: false
    t.integer "user_b_id", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id"

  create_table "local_users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "local_users", ["username"], name: "index_local_users_on_username"

  create_table "logs", force: :cascade do |t|
    t.integer  "intensity"
    t.integer  "rating"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "training_session_id"
  end

  add_index "logs", ["training_session_id"], name: "index_logs_on_training_session_id"
  add_index "logs", ["user_id"], name: "index_logs_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.datetime "datetime"
    t.boolean  "isRead"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "chat_id"
  end

  add_index "messages", ["chat_id"], name: "index_messages_on_chat_id"
  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id"

  create_table "training_sessions", force: :cascade do |t|
    t.datetime "datetime"
    t.integer  "duration"
    t.integer  "level"
    t.integer  "length"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "training_id"
  end

  add_index "training_sessions", ["training_id"], name: "index_training_sessions_on_training_id"

  create_table "trainings", force: :cascade do |t|
    t.boolean  "isPublic"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "sport"
  end

  add_index "trainings", ["owner_id"], name: "index_trainings_on_owner_id"

  create_table "trainings_users", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "training_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
