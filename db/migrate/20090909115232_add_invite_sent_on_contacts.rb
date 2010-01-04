class AddInviteSentOnContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :invite_sent, :boolean, :default => false
  end

  def self.down
    remove_column :contacts, :invite_sent
  end
end
