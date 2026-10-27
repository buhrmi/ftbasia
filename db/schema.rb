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

ActiveRecord::Schema[8.1].define(version: 2026_10_27_063332) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assets", force: :cascade do |t|
    t.string "community_url"
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.integer "decimals"
    t.string "description"
    t.integer "holders_count", default: 0
    t.jsonb "metadata"
    t.string "name"
    t.bigint "network_id"
    t.citext "symbol"
    t.decimal "total_supply", precision: 36, scale: 18
    t.integer "trades_count", default: 0
    t.string "type", default: "Asset"
    t.datetime "updated_at", null: false
    t.index ["contract_address"], name: "index_assets_on_contract_address"
    t.index ["network_id"], name: "index_assets_on_network_id"
    t.index ["symbol"], name: "index_assets_on_symbol"
  end

  create_table "balances", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.decimal "available", precision: 36, scale: 18, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.decimal "locked", precision: 36, scale: 18, default: "0.0", null: false
    t.decimal "total", precision: 36, scale: 18, default: "0.0", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["asset_id"], name: "index_balances_on_asset_id"
    t.index ["user_id", "asset_id"], name: "index_balances_on_user_id_and_asset_id", unique: true
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.decimal "amount", precision: 36, scale: 18, default: "0.0", null: false
    t.bigint "asset_id", null: false
    t.integer "block_height"
    t.integer "confirmations", default: 0
    t.datetime "created_at", null: false
    t.datetime "credited_at"
    t.string "tx"
    t.integer "tx_idx"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "wallet_id", null: false
    t.index ["asset_id"], name: "index_deposits_on_asset_id"
    t.index ["user_id"], name: "index_deposits_on_user_id"
    t.index ["wallet_id", "tx", "tx_idx"], name: "index_deposits_on_wallet_id_and_tx_and_tx_idx", unique: true
    t.index ["wallet_id"], name: "index_deposits_on_wallet_id"
  end

  create_table "guild_connections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "guild_id"
    t.string "guild_name"
    t.jsonb "roles", default: {}
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_guild_connections_on_user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.json "info", default: {}
    t.string "provider"
    t.string "provider_id"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["provider", "provider_id"], name: "index_identities_on_provider_and_provider_id", unique: true
  end

  create_table "networks", force: :cascade do |t|
    t.jsonb "config", default: {}, null: false
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true, null: false
    t.integer "last_scanned_height"
    t.string "name", null: false
    t.string "type", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "amount", precision: 36, scale: 18
    t.datetime "cancelled_at", precision: nil
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.boolean "funded"
    t.bigint "pair_id", null: false
    t.decimal "price", precision: 36, scale: 18
    t.decimal "remaining_amount", precision: 36, scale: 18
    t.decimal "remaining_total", precision: 36, scale: 18
    t.integer "side", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["pair_id", "side", "completed", "cancelled_at", "funded", "price"], name: "index_orders_on_almost_everything"
    t.index ["pair_id"], name: "index_orders_on_pair_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pairs", force: :cascade do |t|
    t.bigint "base_asset_id", null: false
    t.datetime "created_at", null: false
    t.bigint "quote_asset_id", null: false
    t.datetime "updated_at", null: false
    t.index ["base_asset_id"], name: "index_pairs_on_base_asset_id"
    t.index ["quote_asset_id"], name: "index_pairs_on_quote_asset_id"
  end

  create_table "password_resets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "token_digest", null: false
    t.datetime "updated_at", null: false
    t.datetime "used_at"
    t.bigint "user_id", null: false
    t.index ["token_digest"], name: "index_password_resets_on_token_digest", unique: true
    t.index ["user_id"], name: "index_password_resets_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["asset_id"], name: "index_posts_on_asset_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "pair_id", null: false
    t.decimal "price"
    t.integer "side", null: false
    t.datetime "updated_at", null: false
    t.index ["pair_id", "side", "created_at"], name: "index_quotes_on_pair_id_and_side_and_created_at"
    t.index ["pair_id"], name: "index_quotes_on_pair_id"
  end

  create_table "solid_cable_messages", force: :cascade do |t|
    t.binary "channel", null: false
    t.binary "payload", null: false
    t.datetime "created_at", null: false
    t.bigint "channel_hash", null: false
    t.index ["channel_hash"], name: "index_solid_cable_messages_on_channel_hash"
    t.index ["created_at"], name: "index_solid_cable_messages_on_created_at"
  end

  create_table "solid_cache_entries", force: :cascade do |t|
    t.binary "key", null: false
    t.binary "value", null: false
    t.datetime "created_at", null: false
    t.bigint "key_hash", null: false
    t.integer "byte_size", null: false
    t.index ["byte_size"], name: "index_solid_cache_entries_on_byte_size"
    t.index ["key_hash", "byte_size"], name: "index_solid_cache_entries_on_key_hash_and_byte_size"
    t.index ["key_hash"], name: "index_solid_cache_entries_on_key_hash", unique: true
  end

  create_table "solid_queue_batch_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "batch_id", null: false
    t.datetime "created_at", null: false
    t.index ["batch_id"], name: "index_solid_queue_batch_executions_on_batch_id"
    t.index ["job_id"], name: "index_solid_queue_batch_executions_on_job_id", unique: true
  end

  create_table "solid_queue_batches", force: :cascade do |t|
    t.string "active_job_batch_id"
    t.string "description"
    t.text "on_finish"
    t.text "on_success"
    t.text "on_failure"
    t.text "metadata"
    t.integer "total_jobs", default: 0, null: false
    t.integer "completed_jobs", default: 0, null: false
    t.integer "failed_jobs", default: 0, null: false
    t.datetime "enqueued_at"
    t.datetime "finished_at"
    t.datetime "failed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_job_batch_id"], name: "index_solid_queue_batches_on_active_job_batch_id", unique: true
    t.index ["finished_at"], name: "index_solid_queue_batches_on_finished_at"
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments"
    t.integer "priority", default: 0, null: false
    t.string "active_job_id"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "batch_id"
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["batch_id"], name: "index_solid_queue_jobs_on_batch_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.string "queue_name", null: false
    t.datetime "created_at", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.bigint "supervisor_id"
    t.integer "pid", null: false
    t.string "hostname"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["name", "supervisor_id"], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "task_key", null: false
    t.datetime "run_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_recurring_tasks", force: :cascade do |t|
    t.string "key", null: false
    t.string "schedule", null: false
    t.string "command", limit: 2048
    t.string "class_name"
    t.text "arguments"
    t.string "queue_name"
    t.integer "priority", default: 0
    t.boolean "static", default: true, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_solid_queue_recurring_tasks_on_key", unique: true
    t.index ["static"], name: "index_solid_queue_recurring_tasks_on_static"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.string "key", null: false
    t.integer "value", default: 1, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "trades", force: :cascade do |t|
    t.decimal "amount", precision: 36, scale: 18, null: false
    t.bigint "base_asset_id", null: false
    t.bigint "buy_order_id", null: false
    t.bigint "buyer_id", null: false
    t.datetime "created_at", null: false
    t.decimal "price", precision: 36, scale: 18, null: false
    t.bigint "quote_asset_id", null: false
    t.bigint "sell_order_id", null: false
    t.bigint "seller_id", null: false
    t.decimal "total", precision: 36, scale: 18, null: false
    t.datetime "updated_at", null: false
    t.index ["base_asset_id"], name: "index_trades_on_base_asset_id"
    t.index ["buy_order_id"], name: "index_trades_on_buy_order_id"
    t.index ["buyer_id"], name: "index_trades_on_buyer_id"
    t.index ["quote_asset_id"], name: "index_trades_on_quote_asset_id"
    t.index ["sell_order_id"], name: "index_trades_on_sell_order_id"
    t.index ["seller_id"], name: "index_trades_on_seller_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "bio"
    t.datetime "created_at", null: false
    t.citext "email"
    t.citext "handle"
    t.string "locale", default: "en"
    t.string "name"
    t.string "password_digest"
    t.json "socials", default: {}
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["handle"], name: "index_users_on_handle", unique: true
  end

  create_table "verifications", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.citext "email", null: false
    t.datetime "expires_at", null: false
    t.string "kind", default: "email", null: false
    t.datetime "updated_at", null: false
    t.datetime "verified_at"
    t.index ["email"], name: "index_verifications_on_email"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "address"
    t.bigint "asset_id", null: false
    t.datetime "created_at", null: false
    t.string "path"
    t.integer "sequential_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["asset_id"], name: "index_wallets_on_asset_id"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assets", "networks"
  add_foreign_key "balances", "users"
  add_foreign_key "deposits", "assets"
  add_foreign_key "deposits", "users"
  add_foreign_key "deposits", "wallets"
  add_foreign_key "guild_connections", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "pairs", "assets", column: "base_asset_id"
  add_foreign_key "pairs", "assets", column: "quote_asset_id"
  add_foreign_key "password_resets", "users"
  add_foreign_key "posts", "assets"
  add_foreign_key "posts", "users"
  add_foreign_key "solid_queue_batch_executions", "solid_queue_batches", column: "batch_id", on_delete: :cascade
  add_foreign_key "solid_queue_batch_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "trades", "assets", column: "base_asset_id"
  add_foreign_key "trades", "assets", column: "quote_asset_id"
  add_foreign_key "trades", "orders", column: "buy_order_id"
  add_foreign_key "trades", "orders", column: "sell_order_id"
  add_foreign_key "trades", "users", column: "buyer_id"
  add_foreign_key "trades", "users", column: "seller_id"
  add_foreign_key "wallets", "assets"
  add_foreign_key "wallets", "users"
end
