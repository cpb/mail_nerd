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

  @naughty
  Scenario: Generating a Mandrill Mailer
    Given the Mandrill template "Group Invite" is:
    """xml
    <div mc:edit="my_region">foobar</div>
    """
    When I successfully run `bundle exec rails g mail_nerd:mailer Invitations invitor@example.com 'Group Invite'`
    Then the file "app/mailers/invitations.rb" should contain exactly:
    """ruby
    class InvitationMailer < MandrillMailer::TemplateMailer
      default from: 'support@example.com'

      def group_invite(my_region="foobar", recipients=[{email: invitation.email, name: 'Honored Guest'}])
        mandrill_mail template: 'Group Invite',
          subject: I18n.t('invitation_mailer.group_invite.subject'),
          to: recipients,
          vars: {
            my_region: my_region
          },
          important: true,
          inline_css: true
      end
    end
    """
