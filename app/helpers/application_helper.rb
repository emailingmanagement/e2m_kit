# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def label_keys(key)
    I18n.t(key).map {|k, v| [v, k.to_s]}.sort {|x, y| x[1] <=> y[1]}
  end
  
  def admin_mode?
    logged_in? && current_user.email == 'julien.biard@gmail.com'
  end
  
  
  def remove_accent(char)
    case char
    when 'é','è','ê', 'ë' : 'e'
    when 'ï', 'î' : 'i'
    when 'à', 'â' : 'a'
    when 'ç' : 'c'
    when 'ù', 'û', 'ü' : 'u'
    else
      char
    end
  end
  
  def att_url(att)
    "http://#{EMAILING_HOST}#{att.url}"
  end
end
