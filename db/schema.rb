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

ActiveRecord::Schema.define(version: 20161017095348) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "target_id"
    t.integer  "activity_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "book_marks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "read_status"
    t.boolean  "is_favorite"
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "mark_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["book_id"], name: "index_book_marks_on_book_id", using: :btree
    t.index ["user_id", "book_id"], name: "index_book_marks_on_user_id_and_book_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_book_marks_on_user_id", using: :btree
  end

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "publish_date"
    t.integer  "number_of_page",      default: 1
    t.string   "author"
    t.string   "cover"
    t.string   "description"
    t.integer  "number_rate_of_book", default: 0
    t.integer  "avg_rates",           default: 0
    t.integer  "category_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["category_id"], name: "index_books_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "category_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.integer  "review_rate_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["review_rate_id"], name: "index_comments_on_review_rate_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "like_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["activity_id"], name: "index_like_activities_on_activity_id", using: :btree
    t.index ["user_id"], name: "index_like_activities_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
    t.index ["follower_id"], name: "index_relationships_on_follower_id", using: :btree
  end

  create_table "requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "book_name"
    t.string   "author"
    t.string   "content"
    t.datetime "publish_date"
    t.integer  "status",       default: 0
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "review_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",             limit: 65535
    t.integer  "number_rate_of_user",               default: 0
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.index ["book_id"], name: "index_review_rates_on_book_id", using: :btree
    t.index ["user_id"], name: "index_review_rates_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_admin",        default: false
    t.string   "gravatar"
    t.string   "remember_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_foreign_key "activities", "users"
  add_foreign_key "book_marks", "books"
  add_foreign_key "book_marks", "users"
  add_foreign_key "books", "categories"
  add_foreign_key "comments", "review_rates"
  add_foreign_key "comments", "users"
  add_foreign_key "like_activities", "activities"
  add_foreign_key "like_activities", "users"
  add_foreign_key "requests", "users"
  add_foreign_key "review_rates", "books"
  add_foreign_key "review_rates", "users"
end
