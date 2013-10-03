module MandrillIntegrationHelpers
  def with_mandrill_api_key
    if api_key = ENV['MANDRILL_APIKEY'] ||= (begin
                                              MAIL_NERD_CONFIG[:password]
                                             rescue NameError => e
                                               nil
                                             end)
      yield(api_key)
    else
      pending "You have not configured mail_nerd for #{Rails.env} or through the ENV value: MANDRILL_APIKEY"
    end
  end
end
