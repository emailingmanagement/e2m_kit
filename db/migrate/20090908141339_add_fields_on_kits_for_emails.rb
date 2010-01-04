class AddFieldsOnKitsForEmails < ActiveRecord::Migration
  def self.up
    add_column :kits, :email_bg_color, :string
    add_column :kits, :email_links_color, :string
    1.upto(2) do |i|
      add_column :kits, :"email#{i}_picture_file_name", :string
      add_column :kits, :"email#{i}_picture_file_size", :integer
      add_column :kits, :"email#{i}_picture_content_type", :string
      add_column :kits, :"email#{i}_picture_updated_at", :datetime
    end
    add_column :kits, :mail_css_content, :text
  end

  def self.down
    remove_column :kits, :mail_css_content
    1.upto(2) do |i|
      remove_column :kits, :"email#{i}_picture_updated_at"
      remove_column :kits, :"email#{i}_picture_content_type"
      remove_column :kits, :"email#{i}_picture_file_size"
      remove_column :kits, :"email#{i}_picture_file_name"
    end
    remove_column :kits, :email_links_color
    remove_column :kits, :email_bg_color
  end
end