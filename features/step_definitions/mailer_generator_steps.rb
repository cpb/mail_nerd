Given(/^the Mandrill template "(.*?)" is:$/) do |name, code|
  begin
    case code.content_type
    when "yaml"
      from_email,from_name,subject,text,publish,code = YAML::load(code).values_at("from_email","from_name","subject","text","publish","code")
    when "xml"
      code = code
    end

    from_email ||= "from_email@example.com"
    from_name  ||= "Example Name"
    subject    ||= "example subject"
    text       ||= "example text"
    publish    ||= false

    result = mandrill.templates.add name, from_email, from_name, subject, code, text, publish

    register_template_for_cleanup(result)

  rescue Mandrill::InvalidTemplateError => e
    warn e.message
  rescue Excon::Errors::SocketError => e
    retry
  end
end

Given(/^I configure mail_nerd for Mandrill$/) do
  with_mandrill_api_key do |api_key|
    username = ENV['MANDRILL_USERNAME'] || 'adbust+mail_nerd@gmail.com'
    run_simple("bundle exec rake mail_nerd:config[smtp.mandrillapp.com,587,#{username},#{api_key}]")
  end
end
