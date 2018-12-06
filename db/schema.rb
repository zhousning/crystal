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

ActiveRecord::Schema.define(:version => 20150602202312) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "addresses", :force => true do |t|
    t.string   "province"
    t.string   "city"
    t.string   "district"
    t.integer  "teacher_id"
    t.integer  "parent_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "details"
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "appointments", :force => true do |t|
    t.integer  "weekday"
    t.integer  "time"
    t.integer  "course_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
    t.integer  "teacher_id"
  end

  create_table "careers", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "child_name"
    t.string   "school"
    t.string   "subject"
    t.string   "before_score"
    t.string   "after_score"
    t.text     "content"
    t.integer  "teacher_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "subject"
    t.string   "second"
    t.string   "third"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "number"
  end

  create_table "comments", :force => true do |t|
    t.integer  "total"
    t.integer  "desc"
    t.integer  "attitude"
    t.integer  "speed"
    t.string   "content"
    t.integer  "category"
    t.integer  "teacher_id"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.integer  "experence"
    t.string   "mode"
    t.integer  "length"
    t.string   "price"
    t.integer  "status",      :default => 0
    t.integer  "category_id"
    t.integer  "teacher_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "period",      :default => 0
  end

  create_table "galleries", :force => true do |t|
    t.string   "photo"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "honors", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "info_categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "information", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "img"
    t.string   "name"
    t.string   "phone"
    t.string   "qq"
    t.string   "weixin"
    t.string   "number"
    t.integer  "info_category_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "click_times",      :default => 0
    t.string   "qrcode"
    t.string   "qrcode_uid"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "course_id"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "tradecode"
  end

  add_index "line_items", ["course_id"], :name => "index_line_items_on_course_id"
  add_index "line_items", ["order_id"], :name => "index_line_items_on_order_id"

  create_table "messages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "category"
    t.integer  "status",     :default => 1
    t.integer  "parent_id"
    t.integer  "teacher_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "notices", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "category"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "notices_category_id"
    t.string   "number"
  end

  create_table "notices_categories", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_traces", :force => true do |t|
    t.string   "p_content"
    t.string   "t_content"
    t.string   "p_operator"
    t.string   "t_operator"
    t.integer  "status"
    t.integer  "order_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "status",            :default => 0, :null => false
    t.integer  "parent_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "teacher_id"
    t.string   "addr"
    t.datetime "appointments_time"
    t.integer  "hours",             :default => 1
    t.integer  "total",             :default => 1
    t.string   "number"
  end

  create_table "parents", :force => true do |t|
    t.string   "phone",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name",                   :default => "", :null => false
    t.integer  "status",                 :default => 0
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "pay_num"
    t.string   "email"
  end

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.string   "honors_image"
    t.integer  "teacher_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "scores", :force => true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sec_votes", :force => true do |t|
    t.string   "ip"
    t.string   "session"
    t.string   "sign"
    t.string   "sign2"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "student_identities", :force => true do |t|
    t.string   "school"
    t.string   "grade"
    t.string   "major"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teacher_identities", :force => true do |t|
    t.string   "school"
    t.string   "grade"
    t.string   "subject"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teachers", :force => true do |t|
    t.string   "phone",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "name",                   :default => "", :null => false
    t.integer  "age"
    t.integer  "sex"
    t.string   "email"
    t.string   "qq"
    t.string   "hobby"
    t.string   "introduction"
    t.integer  "status",                 :default => 0
    t.integer  "identity"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "paper_img"
    t.string   "paper_id_img"
    t.string   "image"
    t.string   "pay_num"
    t.string   "teacher_paper"
    t.string   "professional_paper"
    t.string   "quotes"
    t.string   "experience"
    t.string   "my_categories"
    t.string   "number"
    t.integer  "period",                 :default => 0
    t.integer  "teaching_age",           :default => 0
    t.text     "study_case"
    t.integer  "join_status",            :default => 0
    t.integer  "score",                  :default => 0
    t.text     "signdate"
    t.integer  "signcount"
    t.string   "qrcode_uid"
  end

  create_table "trades", :force => true do |t|
    t.string   "number"
    t.string   "category"
    t.integer  "price",      :default => 1,         :null => false
    t.integer  "quantity",   :default => 1,         :null => false
    t.integer  "discount"
    t.string   "subject"
    t.string   "trade_no"
    t.string   "state",      :default => "opening", :null => false
    t.integer  "order_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "votes", :force => true do |t|
    t.string   "ip"
    t.string   "sign"
    t.integer  "teacher_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "session"
    t.string   "sign2"
  end

  add_index "votes", ["teacher_id"], :name => "index_votes_on_teacher_id"

end
