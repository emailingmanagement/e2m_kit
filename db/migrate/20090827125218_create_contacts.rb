class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :source, :email
      t.references :subscription
    end
    add_index :contacts, :subscription_id
  end

  def self.down
    drop_table :contacts
  end
end