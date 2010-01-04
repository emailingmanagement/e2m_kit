class AddParentOnSubscriptions < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :parent_id, :integer
    add_index :subscriptions, :parent_id
  end

  def self.down
    remove_column :subscriptions, :parent_id
  end
end
