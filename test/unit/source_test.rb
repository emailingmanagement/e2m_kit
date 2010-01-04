require File.dirname(__FILE__) + '/../test_helper'

class SourceTest < ActiveSupport::TestCase
  should_belong_to :kit
  should_have_many :subscriptions
  should_allow_mass_assignment_of :kit, :name
  should_have_db_index :kit_id
end
