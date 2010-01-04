require File.dirname(__FILE__) + '/../test_helper'

class RoleTest < ActiveSupport::TestCase
  should_have_and_belong_to_many :users
  should_have_db_index :title
  context "uniqueness" do
    setup { Factory(:admin) }
    should_validate_uniqueness_of :title
  end  
end