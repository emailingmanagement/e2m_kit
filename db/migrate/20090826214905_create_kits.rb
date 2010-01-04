class CreateKits < ActiveRecord::Migration
  def self.up
    create_table :kits do |t|
      t.string :lang, :title, :permalink, :name, :picture_content_type, :picture_file_name, :css_content_type, :css_file_name
      t.integer :picture_file_size, :css_file_size
      t.boolean :published, :default => false
      t.datetime :finished_at, :picture_updated_at, :css_updated_at
      t.references :user
      t.timestamps
    end
    add_index :kits, :user_id
  end

  def self.down
    drop_table :kits
  end
end
