class <%= mailer_class_name %> < MandrillMailer::TemplateMailer
  default from:      <%= default_from.inspect %>,
          from_name: <%= default_name.inspect %>

  def <%= template_method_name %>(<%= vars.map{|v| "#{v.argument}=#{v.default.inspect}"}.join(', ') %>, recipients=[{email: "guest@honor.com", name: 'Honored Guest'}])
    mandrill_mail template: <%= template_name.inspect %>,
      subject: I18n.t(<%= translation_key('subject').inspect %>, default: <%= default_subject.inspect %>),
      to: recipients,
      vars: {
    <% vars.each do |var| -%>
    <%= var.symbol %>: <%= var.argument %>
    <% end -%>
  },
      important: true,
      inline_css: true
  end

  test_setup_for <%= template_method_name.to_sym.inspect %> do |mailer, options|
    mailer.<%= template_method_name %>(*options.values_at(<%= vars.map(&:option_key).join(', ') %>), [options.select{|k| [:name,:email].include?(k)}]).deliver
  end
end
