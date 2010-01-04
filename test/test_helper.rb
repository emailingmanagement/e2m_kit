ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  class <<self
    def should_have_attached_file(attachment)
      klass = self.name.gsub(/Test$/, '').constantize

      context "To support a paperclip attachment named #{attachment}, #{klass}" do
        should_have_db_column("#{attachment}_file_name",    :type => :string)
        should_have_db_column("#{attachment}_content_type", :type => :string)
        should_have_db_column("#{attachment}_file_size",    :type => :integer)
      end

      should "have a paperclip attachment named ##{attachment}" do
        assert klass.new.respond_to?(attachment.to_sym), 
               "@#{klass.name.underscore} doesn't have a paperclip field named #{attachment}"
        assert_equal Paperclip::Attachment, klass.new.send(attachment.to_sym).class
      end
    end
  
    def should_have_email(*att)
      att.each do |a|
        should_not_allow_values_for a, "blahh", "b lahh", :message => I18n.t('activerecord.errors.messages')[:email_invalid]
        should_allow_values_for a, "a@b.com", "asdf@asdf.com"
      end
    end
  
    def should_have_url(*att)
      att.each do |a|
        should_not_allow_values_for a, 'fjkerfker', 'htp://mlezalez', 'ftp://yeahbay.com'
        should_allow_values_for a, 'http://bingoo.fr'
      end
    end
  
    def should_have_zip_code(*att)
      att.each do |a|
        should_not_allow_values_for a, 'abndnabz', '215d zzdd', '15OOA'
        should_allow_values_for a, '44000', '44 000', '123456789'
      end
    end
    
    def should_have_phone_number(*att)
      att.each do |a|
        should_not_allow_values_for a, 'dzadzad', 'az az 12'
        should_allow_values_for a, '1234567890', '12 34 56 78 90', '+33 672787178'
      end
    end
    def should_have_label_key(att, opts)
      should_allow_values_for att, *I18n.t(opts[:i18n_keys]).keys.map{|k| k.to_s}
    end    
  end
end
