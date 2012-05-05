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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120505163149) do

  create_table "attachments", :force => true do |t|
    t.integer  "note_id",     :null => false
    t.string   "title",       :null => false
    t.text     "description", :null => false
    t.integer  "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "attachments", ["note_id"], :name => "index_attachments_on_note_id"

  create_table "folders", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.text     "description"
    t.string   "level"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "folders", ["parent_id"], :name => "index_folders_on_parent_id"

  create_table "notes", :force => true do |t|
    t.integer  "folder_id"
    t.integer  "author_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notes", ["author_id"], :name => "index_notes_on_author_id"
  add_index "notes", ["folder_id"], :name => "index_notes_on_folder_id"

  create_table "paragraphs", :force => true do |t|
    t.integer  "note_id"
    t.integer  "prev_id"
    t.integer  "next_id"
    t.integer  "locking_user_id"
    t.text     "text"
    t.datetime "lock_time"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "paragraphs", ["locking_user_id"], :name => "index_paragraphs_on_locking_user_id"
  add_index "paragraphs", ["next_id"], :name => "index_paragraphs_on_next_id"
  add_index "paragraphs", ["note_id"], :name => "index_paragraphs_on_note_id"
  add_index "paragraphs", ["prev_id"], :name => "index_paragraphs_on_prev_id"

  create_table "permission_for_folders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "permission_for_folders", ["folder_id"], :name => "index_permission_for_folders_on_folder_id"
  add_index "permission_for_folders", ["user_id", "folder_id"], :name => "index_permission_for_folders_on_user_id_and_folder_id", :unique => true
  add_index "permission_for_folders", ["user_id"], :name => "index_permission_for_folders_on_user_id"

  create_table "permission_for_notes", :force => true do |t|
    t.string   "level"
    t.integer  "user_id"
    t.integer  "note_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "permission_for_notes", ["note_id", "user_id"], :name => "index_permission_for_notes_on_note_id_and_user_id", :unique => true
  add_index "permission_for_notes", ["note_id"], :name => "index_permission_for_notes_on_note_id"
  add_index "permission_for_notes", ["user_id"], :name => "index_permission_for_notes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
