unless Rails.env.production? || Rails.env.test?

  require 'tlsmail'
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

  ActionMailer::Base.smtp_settings = {
    :address => 'ktb.kingtong.org',
    :port => 465,
    :domain => "vibes.hopto.org",
    :user_name => "brasco@kingtong.org",
    :password => "carapicho",
    :authentication => :login
  }
end
