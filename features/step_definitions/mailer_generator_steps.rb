Given(/^the Mandrill template "(.*?)" is:$/) do |name, code|
  with_mandrill_api_key do |api_key|
    mandrill = Mandrill::API.new(api_key)
    begin
      from_email = "from_email@example.com"
      from_name = "Example Name"
      subject = "example subject"
      text = "example text"
      publish = false
      mandrill.templates.add name, from_email, from_name, subject, code, text, publish
    rescue Mandrill::InvalidTemplateError => e
      warn e.message
    end
  end
end

Given(/^I configure mail_nerd for Mandrill$/) do
  with_mandrill_api_key do |api_key|
    username = ENV['MANDRILL_USERNAME'] || 'adbust+mail_nerd@gmail.com'
    run_simple("bundle exec rake mail_nerd:config[smtp.mandrillapp.com,587,#{username},#{api_key}]")
  end
end
