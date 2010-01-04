require File.dirname(__FILE__) + '/../test_helper'

class KitTest < ActiveSupport::TestCase
  should_have_attached_file :css
  should_have_attached_file :email1_picture
  should_have_attached_file :email2_picture

  should_belong_to :user
  should_have_many :subscriptions
  should_have_many :partners
  should_have_many :css_pictures
  should_have_many :contacts
  should_have_many :sources

  should_allow_mass_assignment_of :lang, :title, :name, :user, :finished_at, :css, :rules, :default_country, :email1_picture, :email2_picture, :email_bg_color, :email_links_color
  should_validate_presence_of :lang, :title, :name, :user, :finished_at, :default_country
  should_have_label_key :lang, :i18n_keys => 'activerecord.attributes.kit.lang_list'

  should_have_db_index :user_id
end