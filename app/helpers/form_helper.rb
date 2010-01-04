module FormHelper
  def custom_label_tag(form, key, options = {})
    form.label(key,
      form_field_name(form.object, options[:label_key] || key) + (options[:label_complement] || '') + (options[:required] ? ' ' + content_tag(:span, '*', :class => :required) : ''), :class => options[:class])
  end
  
  def form_field_name(object, field)
    field_name(object.class.to_s.underscore, field)
  end
  
  def field_name(object, field)
    t("activerecord.attributes.#{object}.#{field}") rescue t("activerecord.attributes.#{object.classify.constantize.superclass.to_s.underscore}.#{field}")
  end
  
  def custom_submit(value = t(:validate), opts = {})
    content_tag(:div, :class => "btn#{opts[:class] ? ' ' + opts[:class] : ''}") do
      content_tag(:span, submit_tag(value, :class => :form_button))
    end
  end
  
end