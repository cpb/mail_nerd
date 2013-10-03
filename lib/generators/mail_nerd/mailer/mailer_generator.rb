class MailNerd::MailerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :name, type: :string, banner: 'name'

  def create_mailer
    template "mailer_class.rb", "app/mailers/#{mailer_file_name}.rb"
  end

  private

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

  def template_name
    "Group Invite"
  end

  def translation_key(leaf="subject")
    [mailer_class_name.underscore,template_method_name,leaf].join('.')
  end

  def default_from
    "invitor@example.com"
  end

  def default_name
    "Invitigat0r"
  end

  def default_subject
    "Default subject for U"
  end

  def vars
    [
      OpenStruct.new(argument: 'my_region',symbol: :my_region,default: 'foobar',option_key: :my_region.inspect)
    ]
  end
end
