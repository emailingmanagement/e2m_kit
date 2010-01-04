class AddKitOnContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :kit_id, :integer
    add_index :contacts, :kit_id
  end

  def self.down
    remove_column :contacts, :kit_id
  end
end
