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

ActiveRecord::Schema.define(:version => 20120501162000) do

  create_table "attachments", :force => true do |t|
    t.integer  "note_id",     :null => false
    t.string   "title",       :null => false
    t.text     "description", :null => false
    t.integer  "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "attachments", ["note_id"], :name => "attachments_note_id_ix"

  create_table "notes", :force => true do |t|
    t.integer  "folder_id"
    t.integer  "author_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notes", ["author_id"], :name => "notes_author_id_ix"
  add_index "notes", ["folder_id"], :name => "notes_folder_id_ix"

  create_table "permission_for_notes", :id => false, :force => true do |t|
    t.string   "level"
    t.integer  "user_id"
    t.integer  "note_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "permission_for_notes", ["note_id"], :name => "permission_for_notes_note_id_ix"
  add_index "permission_for_notes", ["user_id"], :name => "permission_for_notes_user_id_ix"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
