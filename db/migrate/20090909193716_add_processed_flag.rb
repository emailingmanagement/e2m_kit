class AddProcessedFlag < ActiveRecord::Migration
  def self.up
    add_column :partner_subscriptions, :processed, :boolean, :default => false
    add_column :contacts, :processed, :boolean, :default => false
  end

  def self.down
    remove_column :contacts, :processed
    remove_column :partner_subscriptions, :processed
  end
end
