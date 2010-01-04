### ActionView

# exception raised if no label found
module ActionView
  module Helpers
    module TranslationHelper
      # Delegates to I18n#translate but also performs two additional functions. First, it'll catch MissingTranslationData exceptions 
      # and turn them into inline spans that contains the missing key, such that you can see in a view what is missing where.
      #
      # Second, it'll scope the key by the current partial if the key starts with a period. So if you call translate(".foo") from the
      # people/index.html.erb template, you'll actually be calling I18n.translate("people.index.foo"). This makes it less repetitive
      # to translate many keys within the same partials and gives you a simple framework for scoping them consistently. If you don't
      # prepend the key with a period, nothing is converted.
      def translate(key, options = {})
        options[:raise] = true
        I18n.translate(scope_key_by_partial(key), options)
      rescue I18n::MissingTranslationData => e
        # added to have exceptions in dev and test environments
        raise e #if RAILS_ENV['development'] || RAILS_ENV['test']
=begin
        keys = I18n.send(:normalize_translation_keys, e.locale, e.key, e.options[:scope])
        content_tag('span', keys.join(', '), :class => 'translation_missing')
=end
      end
      alias :t :translate
    end
  end
end

# i18n is used with label
module ActionView
  module Helpers
    class InstanceTag
      def to_label_tag(text = nil, options = {})
        options = options.stringify_keys
        name_and_id = options.dup
        add_default_name_and_id(name_and_id)
        options.delete("index")
        options["for"] ||= name_and_id["id"]
        content = if text.blank?
          klass = if object
            object.class
          elsif object_name
            object_name.classify.constantize rescue nil
          else
            nil
          end
          if klass.respond_to?(:human_attribute_name)
            klass.human_attribute_name(method_name)
          else
            method_name.humanize
          end
        else
          text.to_s
        end
        label_tag(name_and_id["id"], content, options)
      end
    end
  end
end

module ActionView
  module Helpers
    module TextHelper
    
      alias_method :default_pluralize, :pluralize
    
      def pluralize(count, singular, plural = nil)
        return default_pluralize(count, singular, plural) unless I18n.locale == :fr
        c = (count.try(:to_i) || 0)
        "#{c} " + (c <= 1 ? singular : (plural || singular.pluralize))
      end
    end
  end
end

#######################################################################################################################

### ActiveRecord

# force utf8 for mysql on create_table
class ActiveRecord::Migration
  class << self
    def create_table(name, options = {})
      if connection.class.to_s == "ActiveRecord::ConnectionAdapters::MysqlAdapter"
        options = { :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci' }.merge(options) 
      end
      super(name, options)
    end
  end
end

# prepare a set of objects to be used in a sql query
module ActiveRecord
  class Base
    def self.param_sql_objects_ids(objects, opts = {})
      opts = { :parenthesis => true }.merge(opts)

      objects.compact!
      unless (class_filter = opts[:class_filter]).blank?
        class_filter = ( String === class_filter ? class_filter.constantize : class_filter )
        objects = objects.select { |o| class_filter === o }
      end

      objects_ids = objects.map { |o| o.id }.uniq.join( ',' )
      objects_ids = '0' if objects_ids.blank?

      opts[:parenthesis] ? "(#{objects_ids})" : objects_ids
    end
  end
end

# validations
module ActiveRecord

  class Base
    # before the validation we convert empty string to nil
    # it's used to allow nil (allow_nil) in validates*
    # otherwise empty strings are analysed...
    before_validation :empty_to_null

    def self.param_sql_objects_ids( objects, opts = {} )
      opts = { :parenthesis => true }.merge( opts )

      objects.compact!
      unless ( class_filter = opts[ :class_filter ] ).blank?
        class_filter = ( String === class_filter ? class_filter.constantize : class_filter )
        objects = objects.select { | o | class_filter === o }
      end

      objects_ids = objects.map { | o | o.id }.uniq.join( ',' )
      objects_ids = '0' if objects_ids.blank?

      opts[ :parenthesis ] ? "(#{objects_ids})" : objects_ids
    end

    protected
      
      # used to convert empty string to nil
      def empty_to_null
        attributes_before_type_cast.each do | key, value |
         write_attribute(key, nil) if value.kind_of?( String ) && value.empty?
        end
      end
      
      def self.contains_one_of_them?( collection1, collection2 )
        if collection1.size > collection2.size
          collection1.each { |elt| return true if collection2.include?( elt ) }
        else
          collection2.each { |elt| return true if collection1.include?( elt ) }
        end  
        false
      end
  end

  module Validations
    RE_EMAIL = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
    RE_ZIP_CODE = /^\d+( \d+)?$/
    RE_PHONE_NUMBER = /^\+?[\d\s]+$/
    
    module ClassMethods

      # check if HTTP or HTTPS urls are valid 
      def validates_url(*attr_names)

        configuration = { 
          :message => I18n.translate('activerecord.errors.messages')[:invalid], 
          :on => :save, 
          :with => nil
        }

        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
        uri_classes = [URI::HTTP, URI::HTTPS]
        uri_classes << URI::FTP if configuration[:with_ftp]
        validates_each(attr_names, configuration) do |record, attr_name, value|
          begin
            record.errors.add(attr_name, configuration[:message]) unless uri_classes.include?(URI.parse(value.to_s).class)
          rescue URI::InvalidURIError
            record.errors.add(attr_name, configuration[:message])
          end

        end
      end

      # check if an e-mail is correct
      def validates_email(*attr_names)
        configuration = {
          :with => RE_EMAIL,
          :message => I18n.translate('activerecord.errors.messages')[:email_invalid]
        }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
        validates_format_of attr_names, configuration
      end
      
      def validates_zip_code(*attr_names)
        configuration = {
          :with => RE_ZIP_CODE,
          :message => I18n.translate('activerecord.errors.messages')[:zip_code]
        }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
        validates_format_of attr_names, configuration
      end
      
      def validates_phone_number(*attr_names)
        configuration = {
          :with => RE_PHONE_NUMBER,
          :message => I18n.translate('activerecord.errors.messages')[:phone_number]
        }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
        validates_format_of attr_names, configuration
      end
      
      def validates_label_key(*attr_names)
        configuration = {}
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
        raise ArgumentError.new("i18n_keys argument is required to have a list") unless configuration[:i18n_keys]
        configuration.update(attr_name.pop) if attr_names.last.is_a?(Hash)
        validates_each(attr_names, configuration) do |record, attr_name, value|
          record.errors.add(attr_name, configuration[:message]) unless I18n.t(configuration[:i18n_keys]).keys.map{|k| k.to_s}.include?(value)
        end
      end
      
    end
  end

end

module ActiveRecord
  class Errors
    def remove(attribute)
      @errors.delete attribute.to_s
    end
  end
end