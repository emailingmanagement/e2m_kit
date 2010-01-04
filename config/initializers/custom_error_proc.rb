ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  error_class = "error-field"
  case html_tag
  when /<input[^>]+radio/
    html_tag
  when /<(input|textarea|select)/
    if(style_attribute = html_tag =~ /class=['"]/)
      html_tag.insert(style_attribute + 7, "#{error_class}; ")
    else  
      first_whitespace = html_tag =~ /\s/
      html_tag[first_whitespace] = " class='#{error_class}' "
    end
    msg = [instance.error_message].flatten.collect {|m| m.gsub("'", "&#39;")}.join(I18n.t('support.array.two_words_connector'))
    html_tag + "<span class='error-label'>#{msg}</span>"
  else
    html_tag
  end
end