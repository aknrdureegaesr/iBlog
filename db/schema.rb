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

ActiveRecord::Schema.define(:version => 20130805095507) do

  create_table "blogs", :force => true do |t|
    t.string   "name"
    t.string   "owner"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "title"
  end

  create_table "comments", :force => true do |t|
    t.integer  "owner_id"
    t.string   "author"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "content_html"
    t.string   "owner_type"
  end

  add_index "comments", ["owner_id", "owner_type"], :name => "index_comments_on_owner_id_and_owner_type"
  add_index "comments", ["owner_id"], :name => "index_comments_on_entry_id"

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "progress"
    t.text     "plans"
    t.text     "problems"
    t.integer  "blog_id"
    t.text     "progress_html"
    t.text     "plans_html"
    t.text     "problems_html"
  end

  create_table "status_messages", :force => true do |t|
    t.string   "author"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.integer "entry_id"
  end

  create_table "weekly_statuses", :force => true do |t|
    t.string   "author"
    t.text     "status"
    t.text     "status_html"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
