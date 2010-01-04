class AddProcessOnSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :processed, :boolean, :default => false
    add_column :subscriptions, :email_used_to_import, :string
  end

  def self.down
    remove_column :subscriptions, :email_used_to_import
    remove_column :subscriptions, :processed
  end
end