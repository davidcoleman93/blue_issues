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

ActiveRecord::Schema.define(version: 20150428185220) do

  create_table "departments", force: true do |t|
    t.string   "dept_name",  null: false
    t.integer  "manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issue_logs", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", force: true do |t|
    t.string   "title",                            null: false
    t.string   "priority",                         null: false
    t.string   "summary"
    t.string   "status",                           null: false
    t.integer  "created_by"
    t.integer  "assigned_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "time_to_complete"
    t.boolean  "accepted",         default: false
    t.boolean  "active_issue",     default: false
  end

  create_table "posts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 45
    t.string   "title"
    t.string   "username",        limit: 25,                 null: false
    t.string   "email",                                      null: false
    t.date     "DOB"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.integer  "department_id"
    t.boolean  "admin",                      default: false
    t.boolean  "manage",                     default: false
    t.boolean  "normal",                     default: false
    t.boolean  "auto_assign",                default: false
    t.boolean  "basic",                      default: false
  end

  create_table "watchers", force: true do |t|
    t.integer  "user_id"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
