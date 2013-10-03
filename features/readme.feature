@disable-bunder
Feature: Installation and Configuration

  Scenario: Installation
    Given a file named "Gemfile" with:
    """
    gem 'mail_nerd', path: '../../'
    """
    When I run `bundle install`
    Then the output should match /Using mail_nerd \(\d+\.\d+\.\d+\)/
