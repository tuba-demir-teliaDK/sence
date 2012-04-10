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

ActiveRecord::Schema.define(:version => 20120410080627) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.integer  "opt"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "questions", :force => true do |t|
    t.string   "opt1"
    t.string   "opt2"
    t.integer  "opt1_ac",                 :default => 0
    t.integer  "opt2_ac",                 :default => 0
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.integer  "user_id"
    t.string   "status",                  :default => "wapproval"
    t.string   "opt1_image_file_name"
    t.string   "opt1_image_content_type"
    t.integer  "opt1_image_file_size"
    t.datetime "opt1_image_updated_at"
    t.string   "opt2_image_file_name"
    t.string   "opt2_image_content_type"
    t.integer  "opt2_image_file_size"
    t.datetime "opt2_image_updated_at"
  end

  add_index "questions", ["opt1", "opt2"], :name => "index_questions_on_opt1_and_opt2", :unique => true
  add_index "questions", ["status"], :name => "index_questions_on_status"
  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "apple_id"
    t.integer  "roles_mask"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
