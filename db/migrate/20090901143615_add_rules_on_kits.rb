class AddRulesOnKits < ActiveRecord::Migration
  def self.up
    add_column :kits, :rules, :text
  end

  def self.down
    remove_column :kits, :rules
  end
end
