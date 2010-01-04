require 'htmlentities'

module ActiveRecord
  module Acts
    module Permalink
      PERMALINK_COLLISION_SEPARATOR = '_'
  
      class InvalidPermalink < StandardError ; end
  
      def self.included(base)
        base.extend(ClassMethods)
      end
  
      module ClassMethods
        def acts_as_permalink(opts = {})
          before_save :make_unique_permalink
          include ActiveRecord::Acts::Permalink::InstanceMethods
        end
      end

      module InstanceMethods
        def to_param
          permalink
        end
        
        def used_to_make_permalink
          raise NotImplementedError.new( 'used_to_make_permalink is an abstract method' )
        end

        private

          def make_permalink
            if ( p = used_to_make_permalink ).blank? || ( p = HTMLEntities.new.decode(p).parameterize ).blank?
              raise InvalidPermalink.new
            end
            p
          end
        
         def make_unique_permalink
           self.permalink = existing_permalinks_in_db(make_permalink)
         end
             
         def existing_permalinks_in_db(new_permalink)
           conditions = "permalink LIKE '#{new_permalink}%'"
           conditions = "#{conditions} AND id <> #{id}" unless new_record?

           permalinks_in_db = self.class.all(:select => 'permalink', :conditions => conditions).map { | obj | obj.permalink }
           return new_permalink if permalinks_in_db.empty?
     
           # we start from the beginning to find holes
           i = 1
           final_permalink = new_permalink
           final_permalink = "#{new_permalink}#{PERMALINK_COLLISION_SEPARATOR}#{i += 1}" while permalinks_in_db.include?(final_permalink)
           final_permalink
         end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Permalink)