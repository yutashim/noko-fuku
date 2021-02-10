
ActiveRecord::Schema.define(version: 2021_02_10_042102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "store_id"
    t.index ["store_id"], name: "index_comments_on_store_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.bigint "store_id"
    t.string "title"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_promotions_on_store_id"
  end

  create_table "store_favorites", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_store_favorites_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_store_favorites_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_store_favorites_on_follower_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "icon"
    t.text "introduction"
    t.integer "postcode"
    t.string "prefecture"
    t.string "city"
    t.string "street_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_stores_on_email", unique: true
  end

  create_table "user_favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_user_favorites_on_store_id"
    t.index ["user_id", "store_id"], name: "index_user_favorites_on_user_id_and_store_id", unique: true
    t.index ["user_id"], name: "index_user_favorites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "stores"
  add_foreign_key "comments", "users"
  add_foreign_key "promotions", "stores"
  add_foreign_key "user_favorites", "stores"
  add_foreign_key "user_favorites", "users"
end
