require 'highline/import'
require 'yaml'

namespace :mail_nerd do

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
end
