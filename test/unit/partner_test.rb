require File.dirname(__FILE__) + '/../test_helper'

class PartnerTest < ActiveSupport::TestCase
  should_have_attached_file :picture
  should_belong_to :user, :kit
  should_have_many :partner_subscriptions, :subscriptions
  
  should_allow_mass_assignment_of :name, :title, :extra_field_name, :description, :picture, :user, :kit
  should_validate_presence_of :name, :title, :description, :user, :kit
  should_have_db_index :user_id, :kit_id
end
