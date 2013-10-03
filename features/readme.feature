@disable-bundler
Feature: Installation and Configuration

  Background: Installation
    Given a rails application
    And I append to "Gemfile" with:
    """
    gem 'mail_nerd', path: '../../../'
    """
    And I run `bundle install`

  Scenario: Configuration
    Given I've created a service api key
    When I run `bundle exec rake mail_nerd:config[smtp.mandrillapp.com,587,username,api_key]`
    Then the file "config/mail_nerd_config.yml" should contain exactly:
    """
    ---
    development:
      host: smtp.mandrillapp.com
      port: '587'
      username: username
      password: api_key

    """
