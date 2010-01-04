class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.string :name, :title, :picture_content_type, :picture_file_name, :extra_field_name
      t.text :description
      t.integer :picture_file_size
      t.datetime :picture_updated_at
      t.references :kit
      t.references :user
      t.timestamps
    end
    add_index :partners, :kit_id
    add_index :partners, :user_id
  end

  def self.down
    drop_table :partners
  end
end
