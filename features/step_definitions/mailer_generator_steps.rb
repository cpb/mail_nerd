Given(/^the Mandrill template "(.*?)" is:$/) do |name, code|
  if api_key = ENV['MANDRILL_API_KEY']
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
  else
    pending("You have not provided a testing MANDRILL_API_KEY to configure MANDRILL with")
  end
end

Given(/^I configure mail_nerd for Mandrill$/) do
  if api_key = ENV['MANDRILL_API_KEY']
    username = ENV['MANDRILL_USERNAME'] || 'adbust+mail_nerd@gmail.com'
    run_simple("bundle exec rake mail_nerd:config[smtp.mandrillapp.com,587,#{username},#{api_key}]")
  else
    pending("You have not provided a testing MANDRILL_API_KEY to configure MANDRILL with")
  end
end
