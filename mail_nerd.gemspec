$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mail_nerd/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mail_nerd"
  s.version     = MailNerd::VERSION
  s.authors     = ["Caleb Buxton"]
  s.email       = ["me@cpb.ca"]
  s.homepage    = "https://github.com/cpb/mail_nerd"
  s.summary     = "Take care of the custom email release and delivery cycle."
  s.description = "So you don't have to."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "mandrill_mailer", "~> 0.4"
end
