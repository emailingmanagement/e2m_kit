require File.dirname(__FILE__) + '/../test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  should_belong_to :kit, :parent, :source
  should_have_many :contacts
  should_allow_mass_assignment_of :email, :civility, :first_name, :last_name, :region, :city, :country, :occupation, :date_of_birth, :kit, :parent, :source
  should_validate_presence_of :email, :civility, :first_name, :last_name, :region, :city, :country, :occupation, :date_of_birth, :kit
  should_have_label_key :civility, :i18n_keys => 'activerecord.attributes.subscription.civility_list'
  should_have_label_key :occupation, :i18n_keys => 'activerecord.attributes.subscription.occupation_list'

  should_not_allow_values_for :email, "blahh", "b lahh", :message => I18n.t('activerecord.errors.messages')[:email_invalid]
  should_allow_values_for :email, "a@b.com", "asdf@asdf.com"
  
  should_have_db_index :kit_id, :parent_id, :source_id
  
  context "uniqueness" do
    setup { Factory(:subscription) }
    should_validate_uniqueness_of :email, :scoped_to => :kit_id, :case_sensitive => false, :message => I18n.t('activerecord.errors.subscription.taken')
  end  
end