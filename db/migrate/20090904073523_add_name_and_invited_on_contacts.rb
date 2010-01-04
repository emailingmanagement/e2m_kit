class AddNameAndInvitedOnContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :invited, :boolean
    add_column :contacts, :name, :string
  end

  def self.down
    remove_column :contacts, :name
    remove_column :contacts, :invited
  end
end
