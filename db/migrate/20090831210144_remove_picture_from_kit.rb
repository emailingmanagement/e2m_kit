class RemovePictureFromKit < ActiveRecord::Migration
  def self.up
    remove_column :kits, :picture_updated_at
    remove_column :kits, :picture_content_type
    remove_column :kits, :picture_file_name
    remove_column :kits, :picture_file_size
  end

  def self.down
    add_column :kits, :picture_file_size, :integer
    add_column :kits, :picture_file_name, :string
    add_column :kits, :picture_content_type, :string
    add_column :kits, :picture_updated_at, :datetime
  end
end
