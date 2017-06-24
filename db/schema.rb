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

ActiveRecord::Schema.define(version: 20170624164026) do

  create_table "books", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title"
    t.integer  "user_id"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.index ["created_at"], name: "index_books_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description", default: ""
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "inspirations", force: :cascade do |t|
    t.integer  "primary_id"
    t.string   "primary_title"
    t.integer  "inspirational_id"
    t.string   "inspirational_title"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["primary_id", "inspirational_id"], name: "index_inspirations_on_primary_id_and_inspirational_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.integer  "book_id"
    t.integer  "recipient_id"
    t.string   "recipient_name"
    t.integer  "sender_id"
    t.string   "sender_name"
    t.string   "book_title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["book_id", "recipient_id", "sender_id"], name: "index_invites_on_book_id_and_recipient_id_and_sender_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.string   "email"
    t.integer  "book_id"
    t.integer  "member_id"
    t.string   "member_name"
    t.string   "book_title"
    t.string   "book_owner_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "files_list"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.index ["book_id", "created_at"], name: "index_tasks_on_book_id_and_created_at"
    t.index ["book_id"], name: "index_tasks_on_book_id"
    t.index ["user_id", "created_at"], name: "index_tasks_on_user_id_and_created_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "email_confirmation"
    t.string   "password_digest"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
