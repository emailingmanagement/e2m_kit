class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :title
    end

    add_index :roles, :title

    create_table :roles_users do |t|
      t.integer :role_id, :user_id
    end

    add_index :roles_users, :role_id
    add_index :roles_users, :user_id
  end

  def self.down
    drop_table :roles
    drop_table :roles_users
  end
end
