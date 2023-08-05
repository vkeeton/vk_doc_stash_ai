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

ActiveRecord::Schema[7.0].define(version: 2023_08_05_085333) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.string "chat_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doc_chats", force: :cascade do |t|
    t.bigint "doc_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_doc_chats_on_chat_id"
    t.index ["doc_id"], name: "index_doc_chats_on_doc_id"
  end

  create_table "docs", force: :cascade do |t|
    t.string "file_name"
    t.string "tag_name"
    t.bigint "user_id", null: false
    t.integer "character_count"
    t.text "content"
    t.string "file_type"
    t.boolean "selected"
    t.string "URL"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_docs_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "contents"
    t.bigint "chat_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "responses", force: :cascade do |t|
    t.text "contents"
    t.bigint "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_responses_on_message_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "user_name"
    t.string "job_title"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "doc_chats", "chats"
  add_foreign_key "doc_chats", "docs"
  add_foreign_key "docs", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "responses", "messages"
end
