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

ActiveRecord::Schema.define(:version => 19) do

  create_table "categories", :force => true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "comments", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "project_id", :null => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["project_id"], :name => "index_comments_on_project_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "friends", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "friend_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friends", ["friend_id"], :name => "index_friends_on_friend_id"
  add_index "friends", ["user_id"], :name => "index_friends_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id",                                     :null => false
    t.integer  "receiver_id",                                   :null => false
    t.integer  "reply_to_id"
    t.string   "content",     :limit => 250
    t.boolean  "read_yn",                    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["read_yn"], :name => "index_messages_on_read_yn"
  add_index "messages", ["receiver_id"], :name => "index_messages_on_receiver_id"
  add_index "messages", ["reply_to_id"], :name => "index_messages_on_reply_to_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "project_prizes", :force => true do |t|
    t.integer  "project_id",  :null => false
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_prizes", ["project_id"], :name => "index_project_prizes_on_project_id"

  create_table "project_updates", :force => true do |t|
    t.integer  "project_id",          :null => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "project_updates", ["project_id"], :name => "index_project_updates_on_project_id"

  create_table "projects", :force => true do |t|
    t.integer  "user_id",                              :null => false
    t.integer  "category_id",                          :null => false
    t.string   "name"
    t.text     "description"
    t.string   "location"
    t.datetime "complete_time",                        :null => false
    t.integer  "views",                :default => 0,  :null => false
    t.integer  "number_of_supporters", :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "success_yn"
    t.integer  "goal_value",           :default => 20, :null => false
  end

  add_index "projects", ["category_id"], :name => "index_projects_on_category_id"
  add_index "projects", ["location"], :name => "index_projects_on_location"
  add_index "projects", ["name"], :name => "index_projects_on_name"
  add_index "projects", ["number_of_supporters"], :name => "index_projects_on_number_of_supporters"
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"
  add_index "projects", ["views"], :name => "index_projects_on_views"

  create_table "user_projects", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "project_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_projects", ["project_id"], :name => "index_user_projects_on_project_id"
  add_index "user_projects", ["user_id"], :name => "index_user_projects_on_user_id"

  create_table "user_sessions", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                  :null => false
    t.text     "description"
    t.string   "location"
    t.string   "crypted_password",                                       :null => false
    t.string   "password_salt",                                          :null => false
    t.string   "name"
    t.string   "username",               :limit => 50
    t.string   "superman",               :limit => 4,  :default => "NO", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_login_time"
    t.datetime "current_login_time"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "last_notification_time"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["location"], :name => "index_users_on_location"
  add_index "users", ["name"], :name => "index_users_on_name"

  create_table "vote_histories", :force => true do |t|
    t.integer "user_id",      :null => false
    t.integer "project_id",   :null => false
    t.boolean "push_or_hide", :null => false
  end

  add_index "vote_histories", ["project_id"], :name => "index_vote_histories_on_project_id"
  add_index "vote_histories", ["user_id"], :name => "index_vote_histories_on_user_id"

end
