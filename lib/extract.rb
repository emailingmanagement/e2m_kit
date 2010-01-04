class Extract
  include Singleton
  
  EXTRACT_DIR = "#{RAILS_ROOT}/extract"
  
  def deliver_extracts
    subscriptions
    partner_subscriptions
    contacts
  end

  private
    def subscriptions
      datas = [
        { :field => 'Kit', :p => Proc.new {|s| s.kit.name } },
        { :field => 'Email', :p => Proc.new { |s| s.email } },
        { :field => 'Civility', :p => Proc.new { |s| s.civility } },
        { :field => 'First name', :p => Proc.new { |s| s.first_name } },
        { :field => 'Last name', :p => Proc.new { |s| s.last_name } },
        { :field => 'Region', :p => Proc.new { |s| s.region } },
        { :field => 'City', :p => Proc.new { |s| s.city } },
        { :field => 'Country', :p => Proc.new { |s| s.country } },
        { :field => 'Occupation', :p => Proc.new { |s| s.occupation } },
        { :field => 'Date of birth', :p => Proc.new { |s| s.date_of_birth } }
      ]
      output_file = "#{EXTRACT_DIR}/#{Date.today}_subscriptions.csv"
      if build_csv(output_file, datas, Subscription)
        ExtractMailer.deliver_extract("[EM][#{Date.today}] - subscriptions", output_file)
      end
    end

    def partner_subscriptions
      datas = [
        { :field => 'Kit', :p => Proc.new {|ps| ps.subscription.kit.name } },
        { :field => 'Partner', :p => Proc.new { |ps| ps.partner.name } },
        { :field => 'Email', :p => Proc.new { |ps| ps.subscription.email } },
        { :field => 'Civility', :p => Proc.new { |ps| ps.subscription.civility } },
        { :field => 'First name', :p => Proc.new { |ps| ps.subscription.first_name } },
        { :field => 'Last name', :p => Proc.new { |ps| ps.subscription.last_name } },
        { :field => 'Region', :p => Proc.new { |ps| ps.subscription.region } },
        { :field => 'City', :p => Proc.new { |ps| ps.subscription.city } },
        { :field => 'Country', :p => Proc.new { |ps| ps.subscription.country } },
        { :field => 'Occupation', :p => Proc.new { |ps| ps.subscription.occupation } },
        { :field => 'Date of birth', :p => Proc.new { |ps| ps.subscription.date_of_birth } },
        { :field => 'Extra name', :p => Proc.new {|ps| ps.partner.extra_field_name } },
        { :field => 'Extra', :p => Proc.new {|ps| ps.extra_field_value } }
      ]
      output_file = "#{EXTRACT_DIR}/#{Date.today}_ps.csv"
      if build_csv(output_file, datas, PartnerSubscription)
        ExtractMailer.deliver_extract("[EM][#{Date.today}] - partner subscriptions", output_file)
      end
    end

    def contacts
      datas = [
        { :field => 'Subscriber email', :p => Proc.new { |c| c.subscription.email } },
        { :field => 'Subscriber country', :p => Proc.new { |c| c.subscription.country } },
        { :field => 'Source', :p => Proc.new { |c| c.source } },
        { :field => 'Email source', :p => Proc.new { |c| c.subscription.email_used_to_import } },
        { :field => 'Email', :p => Proc.new { |c| c.email } },
        { :field => 'Name', :p => Proc.new { |c| c.name } },
        { :field => 'Invited', :p => Proc.new { |c| c.invited ? 'yes' : 'no' } }
      ]
      output_file = "#{EXTRACT_DIR}/#{Date.today}_contacts.csv"
      if build_csv(output_file, datas, Contact)
        ExtractMailer.deliver_extract("[EM][#{Date.today}] - contacts", output_file)
      end
    end
  
    def build_csv(output_file, datas, klass)
      if(collection = klass.all(:conditions => { :processed => false })).blank?
        return false
      end
      FasterCSV.open(output_file, 'w', :col_sep => ';') do | csv |
        csv << datas.map { |h| h[:field] }
        klass.transaction do
          collection.each do |item|
            csv << datas.map { |h| h[:p].call(item).to_s.gsub(/(,|\t|\r|\n|\f)+/, ' ') }
            item.update_attribute(:processed, true)
          end
        end
      end
      true
    end
    
    class ExtractMailer < ActionMailer::Base
      def extract(subject_, file)
        recipients EMAIL_EXTRACTS
        cc EMAIL_EXTRACTS_CC
        subject subject_
        from EMAIL_NO_REPLY
        headers 'return-path' => @from
        part :content_type => "text/plain", :body => File.basename(file)
        attachment :content_type => "text/csv", :body => File.read(file), :filename => File.basename(file)
      end
    end
end