class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string :email, :civility, :first_name, :last_name, :region, :city, :country, :occupation
      t.date :date_of_birth
      t.datetime :created_at
      t.references :kit
    end
    add_index :subscriptions, :kit_id
  end

  def self.down
    drop_table :subscriptions
  end
end