@disable-bundler
Feature: Mailer Generator

  Background: Installed and Configured
    Given a rails application
    And I append to "Gemfile" with:
    """
    gem 'mail_nerd', path: '../../../'
    """
    And I run `bundle install`
    And I configure mail_nerd for Mandrill

  Scenario: Generating a Mandrill Mailer
    Given the Mandrill template "Group Invite" is:
    """yaml
    ---
    from_email: invitor@example.com
    from_name: Invitigat0r
    subject: Default subject for U
    code: |
      <div mc:edit="my_region">foobar</div>
    publish: false
    """
    When I successfully run `bundle exec rails g mail_nerd:mailer Invitations 'Group Invite'`
    Then the file "app/mailers/invitations.rb" should contain exactly:
    """ruby
    class Invitations < MandrillMailer::TemplateMailer
      default from:      "invitor@example.com",
              from_name: "Invitigat0r"

      def group_invite(my_region="foobar", recipients=[{email: "guest@honor.com", name: 'Honored Guest'}])
        mandrill_mail template: "Group Invite",
          subject: I18n.t("invitations.group_invite.subject", default: "Default subject for U"),
          to: recipients,
          vars: {
            my_region: my_region
          },
          important: true,
          inline_css: true
      end

      test_setup_for group_invite do |mailer, options|
        mailer.group_invite(*options.values_at(:my_region), [options.select{|k| [:name,:email].include?(k)}]).deliver
      end
    end

    """
