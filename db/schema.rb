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

ActiveRecord::Schema.define(version: 20141201155750) do

  create_table "answers", force: true do |t|
    t.text     "text"
    t.integer  "answer_value"
    t.integer  "test_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interpretations", force: true do |t|
    t.integer  "scale_id"
    t.integer  "value_from"
    t.integer  "value_to"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "text"
    t.integer  "test_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text2"
  end

  create_table "results", force: true do |t|
    t.integer  "user_id"
    t.integer  "test_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "npp"
  end

  create_table "scale_results", force: true do |t|
    t.integer  "scale_id"
    t.integer  "user_id"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scales", force: true do |t|
    t.integer  "test_id"
    t.string   "name"
    t.string   "questions"
    t.integer  "result"
    t.boolean  "for_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_type"
    t.integer  "order_number"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "sex"
    t.integer  "age"
    t.text     "work"
    t.text     "profession"
    t.text     "workFunction"
    t.integer  "workAge"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cookie"
    t.string   "user_type"
  end

end
