require File.dirname(__FILE__) + '/../test_helper'

class CssPictureTest < ActiveSupport::TestCase
  should_have_attached_file :picture
  should_belong_to :kit
  should_have_db_index :kit_id
end
