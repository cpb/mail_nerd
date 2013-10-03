require 'nokogiri'
require 'mandrill'

class MailNerd::MailerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :name, type: :string, banner: 'class name'
  argument :template_name, type: :string, banner: 'template name'

  def create_mailer
    template "mailer_class.rb", "app/mailers/#{mailer_file_name}.rb"
  end

  private
  def api_key
    @api_key ||= ENV['MANDRILL_APIKEY'] ||= (
      begin
        MAIL_NERD_CONFIG[:password]
      rescue NameError => e
        nil
      end )
  end

  def mandrill
    @mandril ||= Mandrill::API.new(api_key)
  end

  def mandrill_template
    @template_response ||= mandrill.templates.info(template_slug)
  end

  def mailer_file_name
    name.underscore
  end

  def mailer_class_name
    name.camelize
  end

  def template_method_name
    template_name.underscore.gsub(' ','_')
  end

  def template_slug
    template_name.gsub(' ','-')
  end

  def translation_key(leaf="subject")
    [mailer_class_name.underscore,template_method_name,leaf].join('.')
  end

  def default_from
    mandrill_template["from_email"]
  end

  def default_name
    mandrill_template["from_name"]
  end

  def default_subject
    mandrill_template["subject"]
  end

  def code
    @parsed ||= Nokogiri.parse(mandrill_template["code"])
  end

  def vars
    code.xpath("//*[@*]").map do |e|
      name    = e.attributes["mc:edit"].value
      default = e.text

      OpenStruct.new(argument: name,symbol: name.to_sym,default: default,option_key: name.to_sym.inspect)
    end
  end
end
