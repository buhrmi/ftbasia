# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_05_154031) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.json "alt_text", default: {}, null: false
    t.json "caption", default: {}, null: false
    t.string "credit"
    t.integer "position", default: 0, null: false
    t.json "custom_metadata", default: {}, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.json "role", default: {}, null: false
    t.json "location", default: {}, null: false
    t.json "tagline", default: {}, null: false
    t.json "bio", default: {}, null: false
    t.json "links", default: [], null: false
    t.json "sources", default: [], null: false
    t.json "remote_media", default: [], null: false
    t.boolean "featured", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "display_name", default: {}, null: false
    t.index ["slug"], name: "index_artists_on_slug", unique: true
  end

  create_table "event_artists", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "artist_id", null: false
    t.string "role"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_event_artists_on_artist_id"
    t.index ["event_id", "artist_id"], name: "index_event_artists_on_event_id_and_artist_id", unique: true
    t.index ["event_id"], name: "index_event_artists_on_event_id"
  end

  create_table "event_promoters", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "promoter_id", null: false
    t.string "role"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "promoter_id"], name: "index_event_promoters_on_event_id_and_promoter_id", unique: true
    t.index ["event_id"], name: "index_event_promoters_on_event_id"
    t.index ["promoter_id"], name: "index_event_promoters_on_promoter_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "slug", null: false
    t.json "name", default: {}, null: false
    t.json "location", default: {}, null: false
    t.json "bio", default: {}, null: false
    t.json "kind", default: {}, null: false
    t.datetime "starts_at"
    t.string "timezone", default: "Asia/Tokyo", null: false
    t.boolean "all_day", default: false, null: false
    t.json "description", default: {}, null: false
    t.json "work", default: {}, null: false
    t.json "links", default: [], null: false
    t.integer "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_events_on_slug", unique: true
    t.index ["starts_at"], name: "index_events_on_starts_at"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "news_articles", force: :cascade do |t|
    t.string "slug", null: false
    t.string "category", null: false
    t.date "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["published_at"], name: "index_news_articles_on_published_at"
    t.index ["slug"], name: "index_news_articles_on_slug", unique: true
  end

  create_table "news_artists", force: :cascade do |t|
    t.integer "news_article_id", null: false
    t.integer "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_news_artists_on_artist_id"
    t.index ["news_article_id", "artist_id"], name: "index_news_artists_on_news_article_id_and_artist_id", unique: true
    t.index ["news_article_id"], name: "index_news_artists_on_news_article_id"
  end

  create_table "news_embeds", force: :cascade do |t|
    t.integer "news_article_id", null: false
    t.string "title", null: false
    t.string "source_url", null: false
    t.string "provider", null: false
    t.integer "height", default: 400, null: false
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_article_id", "position"], name: "index_news_embeds_on_news_article_id_and_position"
    t.index ["news_article_id"], name: "index_news_embeds_on_news_article_id"
  end

  create_table "news_events", force: :cascade do |t|
    t.integer "news_article_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_news_events_on_event_id"
    t.index ["news_article_id", "event_id"], name: "index_news_events_on_news_article_id_and_event_id", unique: true
    t.index ["news_article_id"], name: "index_news_events_on_news_article_id"
  end

  create_table "news_promoters", force: :cascade do |t|
    t.integer "news_article_id", null: false
    t.integer "promoter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_article_id", "promoter_id"], name: "index_news_promoters_on_news_article_id_and_promoter_id", unique: true
    t.index ["news_article_id"], name: "index_news_promoters_on_news_article_id"
    t.index ["promoter_id"], name: "index_news_promoters_on_promoter_id"
  end

  create_table "news_translations", force: :cascade do |t|
    t.integer "news_article_id", null: false
    t.string "locale", null: false
    t.string "title", null: false
    t.text "description", default: "", null: false
    t.text "body_markdown", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_article_id", "locale"], name: "index_news_translations_on_news_article_id_and_locale", unique: true
    t.index ["news_article_id"], name: "index_news_translations_on_news_article_id"
  end

  create_table "promoters", force: :cascade do |t|
    t.string "slug", null: false
    t.json "name", default: {}, null: false
    t.json "description", default: {}, null: false
    t.json "links", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_promoters_on_slug", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "slug", null: false
    t.json "name", default: {}, null: false
    t.json "location", default: {}, null: false
    t.json "links", default: [], null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_venues_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "event_artists", "artists"
  add_foreign_key "event_artists", "events"
  add_foreign_key "event_promoters", "events"
  add_foreign_key "event_promoters", "promoters"
  add_foreign_key "events", "venues"
  add_foreign_key "news_artists", "artists"
  add_foreign_key "news_artists", "news_articles"
  add_foreign_key "news_embeds", "news_articles"
  add_foreign_key "news_events", "events"
  add_foreign_key "news_events", "news_articles"
  add_foreign_key "news_promoters", "news_articles"
  add_foreign_key "news_promoters", "promoters"
  add_foreign_key "news_translations", "news_articles"
end
