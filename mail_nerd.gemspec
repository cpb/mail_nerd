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
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "highline", "~> 1.6"
  s.add_dependency "rails", "~> 3.0.20"
  s.add_dependency "nokogiri", "~> 1.6"
  s.add_dependency "mandrill_mailer", "~> 0.4"
  s.add_development_dependency "aruba", "~> 0.5"
  s.add_development_dependency "cucumber-rails", "~> 1.4"
  s.add_development_dependency "nifty-generators", "~> 0.4"
  s.add_development_dependency "rspec-rails", "~> 2.14"
end
