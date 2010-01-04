class CreateCssPictures < ActiveRecord::Migration
  def self.up
    create_table :css_pictures do |t|
      t.string :picture_file_name, :picture_content_type
      t.integer :picture_file_size
      t.datetime :picture_updated_at
      t.references :kit
      t.timestamps
    end
    add_index :css_pictures, :kit_id
  end

  def self.down
    drop_table :css_pictures
  end
end
