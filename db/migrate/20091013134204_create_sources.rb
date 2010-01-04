class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.references :kit
      t.string :name
    end
    add_index :sources, :kit_id
    add_column :subscriptions, :source_id, :integer
    add_index :subscriptions, :source_id
  end

  def self.down
    remove_column :subscriptions, :source_id
    drop_table :sources
  end
end
