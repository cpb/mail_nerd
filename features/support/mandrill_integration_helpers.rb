module MandrillIntegrationHelpers
  def with_mandrill_api_key
    if api_key = ENV['MANDRILL_APIKEY'] ||= (begin
                                              MAIL_NERD_CONFIG[:password]
                                             rescue NameError => e
                                               nil
                                             end)
      begin
        yield(api_key)
      rescue Mandrill::InvalidKeyError => e
        require 'pry'
        binding.pry
        raise e
      end
    else
      pending "You have not configured mail_nerd for #{Rails.env} or through the ENV value: MANDRILL_APIKEY"
    end
  end

  def register_template_for_cleanup(template_api_call)
    @templates_for_cleanup.add(template_api_call["slug"])
  end

  def mandrill
    @mandrill
  end

  Before = lambda do |scenario|
    @mandrill = with_mandrill_api_key do |api_key|
      Mandrill::API.new(api_key)
    end

    @templates_for_cleanup = Set.new
  end.freeze

  After = lambda do |scenario|
    @templates_for_cleanup.each do |slug|
      mandrill.templates.delete slug
    end
  end.freeze
end
