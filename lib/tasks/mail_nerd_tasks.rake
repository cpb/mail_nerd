require 'highline/import'
require 'yaml'

namespace :mail_nerd do

  desc "Create config"
  task :config, %w(host port username password) do |t, args|
    configuration = args.to_hash.stringify_keys
    configuration['host'] ||= ask("What's the host of the service?").to_s
    configuration['port'] ||= ask("What's the port of the service?").to_i
    configuration['username'] ||= ask("What's your username for the service?").to_s
    configuration['password'] ||= ask("What's your password for the service?").to_s

    say "Thanks!"

    FileUtils.mkdir_p('config')
    File.open('config/mail_nerd_config.yml','w') do |file|
      file.write(YAML::dump({'development' => configuration}))
    end
  end

  desc "Create a mailer"
  task :mailer, %w(class_name template_name) do |t, args|
    args = args.to_hash.stringify_keys
    args['class_name'] ||= ask("What's the ClassName you desire?").to_s
    args['template_name'] ||= ask("What's the 'Template Name' you want to use?").to_s

    require 'rails/generators'
    require 'generators/mail_nerd/mailer/mailer_generator'

    MailNerd::MailerGenerator.new(args.values_at('class_name','template_name')).invoke_all
  end
end
