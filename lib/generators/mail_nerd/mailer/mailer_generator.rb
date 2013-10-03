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
end
