class AddDefaultCountryOnKits < ActiveRecord::Migration
  def self.up
    add_column :kits, :default_country, :string
  end

  def self.down
    remove_column :kits, :default_country
  end
end
