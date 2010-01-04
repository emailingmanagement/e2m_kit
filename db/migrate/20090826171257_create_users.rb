class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string   "crypted_password"
      t.string   "password_salt"
      t.string   "email"
      t.string   "persistence_token"
      t.string   "perishable_token"
      t.integer  "login_count",          :default => 0
      t.integer  "failed_login_count",   :default => 0
      t.datetime "last_request_at"
      t.datetime "last_login_at"
      t.datetime "current_login_at"
      t.string   "last_login_ip"
      t.string   "current_login_ip"
      t.string   "first_name"
      t.string   "last_name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "permalink"
    end

    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
    add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
    add_index "users", ["permalink"], :name => "index_users_on_permalink", :unique => true
    add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  end

  def self.down
    drop_table :users
  end
end