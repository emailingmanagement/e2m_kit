class CreatePartnerSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :partner_subscriptions do |t|
      t.string :extra_field_value
      t.references :subscription, :partner
    end
    add_index :partner_subscriptions, :subscription_id
    add_index :partner_subscriptions, :partner_id
  end

  def self.down
    drop_table :partner_subscriptions
  end
end
